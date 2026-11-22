#!/usr/bin/env bash
# Push store paths to carbon's harmonia cache and root them for retention.
# Usage: push-cache.sh <revision> <store-path>...
#
# The runner -> carbon path is single-flow limited, so the closure is split
# across parallel nix copy connections. Paths carbon can pull from its own
# substituters are not sent; compression is left to ssh.
set -euo pipefail

if [ "$#" -lt 2 ]; then
    echo "usage: $0 <revision> <store-path>..." >&2
    exit 2
fi

revision="$1"
shift

parallel="${PUSH_PARALLEL:-16}"

workdir="${RUNNER_TEMP:-/tmp}/carbon-cache"
mkdir -p "$workdir"
chmod 700 "$workdir"

signing_key="$workdir/signing.sec"
printf '%s' "$CARBON_CACHE_SIGNING_KEY" >"$signing_key"
chmod 600 "$signing_key"

ssh_key="$workdir/id_ed25519"
# CARBON_CACHE_SSH_KEY is base64 of the private key, single line.
printf '%s' "$CARBON_CACHE_SSH_KEY" | base64 -d >"$ssh_key"
chmod 600 "$ssh_key"
ssh-keygen -y -f "$ssh_key" >/dev/null

known_hosts="$workdir/known_hosts"
cat >"$known_hosts" <<'EOF'
toastyx.dev ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJeIC7Vh01/wnOmBZYqL07y/YdU/Lshic3YQLp8Xi4+J
EOF

ssh_opts=(
    -i "$ssh_key"
    -o IdentitiesOnly=yes
    -o UserKnownHostsFile="$known_hosts"
    -o StrictHostKeyChecking=yes
    -o Compression=yes
    -o IPQoS=throughput
)
export NIX_SSHOPTS="${ssh_opts[*]}"

mapfile -t closure < <(nix-store -qR "$@")
nix store sign --key-file "$signing_key" "${closure[@]}"

shard_dir="$workdir/shards"
rm -rf "$shard_dir"
mkdir -p "$shard_dir"

# Balance shards by closure size; a handful of large paths would otherwise
# finish last and leave the other connections idle.
declare -a totals=()
for ((i = 0; i < parallel; i++)); do
    : >"$shard_dir/$i"
    totals[i]=0
done
while IFS=$'\t' read -r size path; do
    best=0
    for ((i = 1; i < parallel; i++)); do
        if ((totals[i] < totals[best])); then
            best=$i
        fi
    done
    printf '%s\n' "$path" >>"$shard_dir/$best"
    totals[best]=$((totals[best] + size))
done < <(nix path-info -S "${closure[@]}" | awk '{print $2 "\t" $1}' | sort -rn)

pids=()
for shard in "$shard_dir"/*; do
    mapfile -t paths <"$shard"
    if [ "${#paths[@]}" -eq 0 ]; then
        continue
    fi
    nix copy --no-recursive --substitute-on-destination \
        --to ssh-ng://ci-cache@toastyx.dev "${paths[@]}" &
    pids+=("$!")
done

failed=0
for pid in "${pids[@]}"; do
    wait "$pid" || failed=1
done
if [ "$failed" -ne 0 ]; then
    echo "one or more cache push shards failed" >&2
    exit 1
fi

ssh "${ssh_opts[@]}" ci-cache@toastyx.dev \
    /run/current-system/sw/bin/carbon-builder roots add \
    -roots-dir /var/lib/ci-cache/gcroots \
    -revision "$revision" \
    -min-free-gib 30 \
    -nix-store /run/current-system/sw/bin/nix-store \
    "$@"
