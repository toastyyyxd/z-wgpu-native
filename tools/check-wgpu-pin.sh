#!/usr/bin/env sh
# Check vendor/wgpu-native, ffi/webgpu-headers and readme against the pin.
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
version_file="$root/wgpu-native-version"
[ -f "$version_file" ] || { echo "missing $version_file" >&2; exit 1; }

# shellcheck disable=SC1090
. "$version_file"

fail() {
    echo "wgpu-native pin check failed: $*" >&2
    exit 1
}

vendor="$root/vendor/wgpu-native"
{ [ -e "$vendor/.git" ] || [ -f "$vendor/.git" ]; } || fail "$vendor is not a submodule checkout"

have_commit=$(git -C "$vendor" rev-parse HEAD)
[ "$have_commit" = "$wgpu_native_commit" ] ||
    fail "vendor/wgpu-native is at $have_commit, expected $wgpu_native_tag ($wgpu_native_commit)"

have_tag=$(git -C "$vendor" describe --tags --exact-match 2>/dev/null || true)
if [ -n "$have_tag" ]; then
    [ "$have_tag" = "$wgpu_native_tag" ] ||
        fail "vendor/wgpu-native tag is $have_tag, expected $wgpu_native_tag"
else
    echo "warning: vendor/wgpu-native has no local tag (shallow/submodule clone); commit checked instead" >&2
fi

dirty=$(git -C "$vendor" status --porcelain)
[ -z "$dirty" ] ||
    fail "vendor/wgpu-native has uncommitted or untracked files (remove build artifacts such as *.pch):
$dirty"

headers="$vendor/ffi/webgpu-headers"
have_headers=$(git -C "$headers" rev-parse HEAD 2>/dev/null || true)
[ "$have_headers" = "$webgpu_headers_commit" ] ||
    fail "ffi/webgpu-headers is at ${have_headers:-<missing>}, expected $webgpu_headers_commit"

# The readme names the tag and the short hashes.
commit_short=$(printf '%s' "$wgpu_native_commit" | cut -c1-7)
headers_short=$(printf '%s' "$webgpu_headers_commit" | cut -c1-8)
grep -Fq "$wgpu_native_tag" "$root/readme.md" || fail "readme.md does not mention $wgpu_native_tag"
grep -Fq "$commit_short" "$root/readme.md" || fail "readme.md does not mention commit $commit_short"
grep -Fq "$headers_short" "$root/readme.md" || fail "readme.md does not mention webgpu-headers $headers_short"

echo "wgpu-native pin OK: $wgpu_native_tag ($wgpu_native_commit, headers $webgpu_headers_commit)"
