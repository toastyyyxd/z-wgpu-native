{
  description = "z_wgpu_native";

  inputs = {
    self = { submodules = true; };
    zig2nix.url = "github:cloudef/zig2nix";
    zls-overlay.url = "github:zigtools/zls";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { zig2nix, zls-overlay, rust-overlay, ... }: let
    flake-utils = zig2nix.inputs.flake-utils;
  in (flake-utils.lib.eachDefaultSystem (system: let
    
    # Packages
    zig-bin = zig2nix.outputs.packages.${system}.zig-0_17_1;
    env = zig2nix.outputs.zig-env.${system} { zig = zig-bin; };
    zls = zls-overlay.packages.${system}.zls;
    ndkPkgs = import hostPkgs.path {
      inherit system;
      config = hostPkgs.config // { allowUnfree = true; };
    };
    androidNdk = ndkPkgs.androidenv.androidPkgs.ndk-bundle;
    ndkRoot = "${androidNdk}/libexec/android-sdk/ndk/${androidNdk.version}";
    androidRust = (rust-overlay.lib.mkRustBin {} hostPkgs).stable.latest.default.override {
      targets = [ "aarch64-linux-android" "armv7-linux-androideabi" "x86_64-linux-android" ];
    };
    ndkBin = "${ndkRoot}/toolchains/llvm/prebuilt/linux-x86_64/bin";
    hostPkgs = env.pkgs;
    inherit (hostPkgs) lib;

    # Goddamn triples
    zigToRustTriple = {
      "x86_64-linux-musl"   = "x86_64-unknown-linux-musl";
      "aarch64-linux-musl"  = "aarch64-unknown-linux-musl";
      "x86_64-linux-gnu"    = "x86_64-unknown-linux-gnu";
      "aarch64-linux-gnu"   = "aarch64-unknown-linux-gnu";
      "x86_64-windows-gnu"  = "x86_64-pc-windows-gnullvm";
      "aarch64-windows-gnu" = "aarch64-pc-windows-gnullvm";
      "aarch64-linux-android" = "aarch64-linux-android";
      "arm-linux-android"     = "armv7-linux-androideabi";
      "x86_64-linux-android"  = "x86_64-linux-android";
    };

    androidTriples = [
      "aarch64-linux-android"
      "arm-linux-android"
      "x86_64-linux-android"
    ];

    targetTriples = [
      "x86_64-linux-gnu"
      "aarch64-linux-gnu"
      "x86_64-linux-musl"
      "aarch64-linux-musl"
      "x86_64-windows-gnu"
      "aarch64-windows-gnu"
    ];

    # Platform specific dependencies and config
    linuxInputs = { pkgs }: {
      buildInputs = with pkgs; [
        vulkan-loader wayland libxkbcommon libx11 libxcursor libxrandr libxi libGL
      ];
    };

    windowsInputs = { pkgs }: {
      zigBuildFlags = [ "-fwine" ];
      buildInputs = [ ];
      nativeBuildInputs = with hostPkgs; [
        wineWow64Packages.stable
        fontconfig
        llvmPackages.bintools
      ];
      env = {
        FONTCONFIG_FILE = hostPkgs.makeFontsConf {
          fontDirectories = [ hostPkgs.dejavu_fonts ];
        };
        WINEHEADLESS = "1";
        WINEDEBUG = "-all";
        WINEPREFIX = "/build/.wine"; 
        XDG_RUNTIME_DIR = "/build/.runtime";
        HOME = "/build/.home";
      };
      preBuild = ''
        mkdir -p /build/.wine /build/.runtime /build/.home /build/.cache
      '';
    };

    # Main
    mkBuild = {
      pkgs,
      buildTarget ? null,
      extraRustTargets ? [],
      skipZigIncludes ? false,
      bindgenHook ? true,
      includeGlfw ? true,
      preferMusl ? true,
      wrapperBins ? [],
      wrapperLibs ? [],
      wrapperArgs ? [],
      extraEnv ? {},
      zigBuildFlags ? [ "-Doptimize=ReleaseFast" "-Dtest=true" "-Dmode=full" ],
      extraBuildInputs ? [],
      extraNativeBuildInputs ? [],
      extraInputs ? {},
    }: let
      isCross = buildTarget != null && zigToRustTriple.${buildTarget} != hostPkgs.stdenv.hostPlatform.rust.rustcTarget;
      
      # 1. Get the base target from zig2nix
      baseZigTarget = if isCross then (env.target buildTarget).zig else "native";
      
      # 2. Check if we are cross-compiling specifically to a GNU Linux target
      isCrossLinuxGnu = isCross && lib.hasSuffix "linux-gnu" buildTarget;
      
      # 3. Dynamically append the stdenv's libc version ONLY for cross GNU targets. 
      zigTarget = if isCrossLinuxGnu 
                  then "${baseZigTarget}.${pkgs.stdenv.cc.libc.version}" 
                  else baseZigTarget;
                  
      zigTargetFlag = if isCross then "-target ${zigTarget}" else "";
      
      rustTriple = if isCross then zigToRustTriple.${buildTarget} else hostPkgs.stdenv.hostPlatform.rust.rustcTarget;      
      upperRustTriple = lib.toUpper (builtins.replaceStrings ["-"] ["_"] rustTriple);
      bindgenRustTriple = builtins.replaceStrings ["-"] ["_"] rustTriple;

      rust-bin = rust-overlay.lib.mkRustBin {} hostPkgs;
      rustToolchain = rust-bin.stable.latest.default.override {
        targets = [ rustTriple ] ++ extraRustTargets;
      };

      dynamicLinker = hostPkgs.stdenv.cc.bintools.dynamicLinker or "";

      zigWrappers = hostPkgs.runCommand "zig-wrappers-${rustTriple}" {} ''
        mkdir -p $out/bin
        
        cat > $out/bin/${rustTriple}-cc <<'EOF'
        #!/usr/bin/env bash
        declare -a args
        is_static=0
        for arg in "$@"; do
          if [[ "$arg" == "-static" ]]; then is_static=1; fi
          case "$arg" in
            -Wl,*.def) args+=("''${arg#-Wl,}") ;;
            -nolibc | -nodefaultlibs | -nostdlib) ;; # rust likes to do this for some reason but we are using zig's built in stuff
            -lmsvcrt) ;; # get rid of explicit msvcrt to prevent zig from looking for a dll thats not there
            -Wl,--fix-cortex-a53-843419 | --fix-cortex-a53-843419) ;; # gcc-only workaround, lld rejects it
            *) args+=("$arg") ;;
          esac
        done

        # dyn link workaround for a cross entry that matches the host on nixos
        if [[ $is_static -eq 0 && "${rustTriple}" == "${hostPkgs.stdenv.hostPlatform.rust.rustcTarget}" && "${dynamicLinker}" != "" ]]; then
           args+=("-Wl,-dynamic-linker,${dynamicLinker}")
        fi

        exec ${zig-bin}/bin/zig cc ${zigTargetFlag} "''${args[@]}"
        EOF
        chmod +x $out/bin/${rustTriple}-cc
        
        cat > $out/bin/${rustTriple}-cxx <<'EOF'
        #!/usr/bin/env bash
        declare -a args
        is_static=0
        for arg in "$@"; do
          if [[ "$arg" == "-static" ]]; then is_static=1; fi
          case "$arg" in
            -Wl,*.def) args+=("''${arg#-Wl,}") ;;
            -nolibc | -nodefaultlibs | -nostdlib) ;; # rust likes to do this for some reason but we are using zig's built in stuff
            -lmsvcrt) ;; # get rid of explicit msvcrt to prevent zig from looking for a dll thats not there
            -Wl,--fix-cortex-a53-843419 | --fix-cortex-a53-843419) ;; # gcc-only workaround, lld rejects it
            *) args+=("$arg") ;;
          esac
        done

        # commented in the cc wrapper part ^
        if [[ $is_static -eq 0 && "${rustTriple}" == "${hostPkgs.stdenv.hostPlatform.rust.rustcTarget}" && "${dynamicLinker}" != "" ]]; then
           args+=("-Wl,-dynamic-linker,${dynamicLinker}")
        fi

        exec ${zig-bin}/bin/zig c++ ${zigTargetFlag} "''${args[@]}"
        EOF
        chmod +x $out/bin/${rustTriple}-cxx
        
        for tool in ar dlltool ranlib rc objcopy nm strip; do
          cat > $out/bin/${rustTriple}-$tool <<EOF
        #!/usr/bin/env bash
        exec ${zig-bin}/bin/zig $tool "\$@"
        EOF
          chmod +x $out/bin/${rustTriple}-$tool
          
          # rust looks for this `<arch>-w64-mingw32-<tool>` for windows targets
          if [[ "${rustTriple}" == *"windows-gnu"* || "${rustTriple}" == *"windows-gnullvm"* ]]; then
             rust_triple_bash="${rustTriple}"
             mingw_arch="''${rust_triple_bash%%-*}"
             ln -s $out/bin/${rustTriple}-$tool $out/bin/''${mingw_arch}-w64-mingw32-$tool
          fi
        done

        patchShebangs $out/bin
      '';        

      cargoEnv = lib.optionalAttrs isCross (let
        # libclang doesn't have gnullvm just gnu, rust has gnu vs gnullvm so we gotta map it for clang i hate triples
        clangTarget = builtins.replaceStrings ["gnullvm"] ["gnu"] rustTriple;
      in {
        "CARGO_TARGET_${upperRustTriple}_LINKER" = "${zigWrappers}/bin/${rustTriple}-cc";
        "CC_${bindgenRustTriple}" = "${zigWrappers}/bin/${rustTriple}-cc";
        "CXX_${bindgenRustTriple}" = "${zigWrappers}/bin/${rustTriple}-cxx";
        "AR_${bindgenRustTriple}" = "${zigWrappers}/bin/${rustTriple}-ar";
        "TARGET_DLLTOOL" = "${zigWrappers}/bin/${rustTriple}-dlltool";
        "DLLTOOL" = "${zigWrappers}/bin/${rustTriple}-dlltool";
        "BINDGEN_EXTRA_CLANG_ARGS_${bindgenRustTriple}" = "--target=${clangTarget}";
      } // lib.optionalAttrs (lib.hasInfix "windows" rustTriple) {
        # rustc passes --unwindlib=libunwind, which zig cc does not translate.
        "CARGO_TARGET_${upperRustTriple}_RUSTFLAGS" = "-C link-arg=-lunwind";
      });

      buildInputs = lib.optional includeGlfw (if isCross && lib.hasInfix "windows" buildTarget
         then (env.zigCrossPkgsForTarget buildTarget).glfw.overrideAttrs (oldAttrs: {
           # linux's glib's mesonEmulatorHook for some reason gets the wrong target when using zigCrossPkgs
           # and window's mingw_w64 fails to build on aarch64 and plain crossPkgs/nixpkgs.pkgsCross
           postPatch = (oldAttrs.postPatch or "") + ''
             # Remove the Windows resource file from the build to bypass zig rc wrapper issues
             find . -name "CMakeLists.txt" -exec sed -i '/glfw\.rc/d' {} +
           '';
         })
         else pkgs.glfw) ++ extraBuildInputs ++ (extraInputs.buildInputs or []);
      
      nativeBuildInputs = (with hostPkgs.buildPackages; [
        rustToolchain
        zigWrappers
        llvmPackages.libclang.lib
        rustPlatform.cargoSetupHook
      ] ++ lib.optional bindgenHook hostPkgs.buildPackages.rustPlatform.bindgenHook) ++ [ (extraInputs.clang or hostPkgs.llvmPackages.clang) ] ++ extraNativeBuildInputs ++ (extraInputs.nativeBuildInputs or []);
      
      finalEnv = {
        LIBCLANG_PATH = "${hostPkgs.buildPackages.llvmPackages.libclang.lib}/lib";
        CARGO_BUILD_TARGET = rustTriple;
      } // cargoEnv // extraEnv // (extraInputs.env or {});

    in env.package {
      src = lib.cleanSource ./.;
      inherit zigTarget nativeBuildInputs buildInputs;
      zigBuildFlags = zigBuildFlags ++ [ "-Dcargo-target=${rustTriple}" ] ++ (extraInputs.zigBuildFlags or []);
      zigPreferMusl = preferMusl;
      zigWrapperBins = wrapperBins;
      zigWrapperLibs = wrapperLibs;
      zigWrapperArgs = wrapperArgs;
      env = finalEnv;
      cargoRoot = "vendor/wgpu-native";
      cargoDeps = hostPkgs.rustPlatform.importCargoLock {
        lockFile = ./vendor/wgpu-native/Cargo.lock;
      };
      preBuild = (if isCross && !skipZigIncludes then ''
        set +e # no crashy
        echo "Extracting Zig C/C++ include paths for ${rustTriple}..."
        
        # Ask Zig CC for the target's include directories. 
        # Using awk instead of grep prevents 'exit code 1' if no match is found, 
        # and filtering by '^ +/' ensures we only grab actual absolute directory paths.
        ZIG_INCLUDES=$(${zigWrappers}/bin/${rustTriple}-cc -v -E -xc /dev/null 2>&1 | awk '/^ +\// {print "-isystem", $1}' | tr '\n' ' ')
        
        echo "Zig includes found: $ZIG_INCLUDES"
        set -e
        
        export BINDGEN_EXTRA_CLANG_ARGS_${bindgenRustTriple}="$BINDGEN_EXTRA_CLANG_ARGS_${bindgenRustTriple} $ZIG_INCLUDES"
      '' else "") + "\n" + (extraInputs.preBuild or "");
    };

    mkCross = triple: let
      crossPkgs = env.crossPkgsForTarget triple;
    in mkBuild {
      # we use zig to cross compile, for some reason mingw_w64 on nixpkgs for aarch64 SEEMS to have x86 asm which crashes the build
      pkgs = crossPkgs;
      buildTarget = triple;
      preferMusl = lib.hasInfix "musl" triple;
      # Cross packages are build-only: tests cannot run for these targets anyway,
      # and skipping them drops the cross glfw/fontconfig/tzdata closure.
      includeGlfw = false;
      zigBuildFlags = [ "-Doptimize=ReleaseFast" "-Dmode=full" "-Dskip-codegen=true" ];
      extraInputs = { clang = hostPkgs.llvmPackages.clang-unwrapped; } //
        (if lib.hasInfix "linux" triple then linuxInputs { pkgs = crossPkgs; }
        else if lib.hasInfix "windows" triple then windowsInputs { pkgs = crossPkgs; }
        else {});
    };

    mkAndroid = triple: let
      rustTriple = zigToRustTriple.${triple};
      upperRustTriple = lib.toUpper (builtins.replaceStrings ["-"] ["_"] rustTriple);
      bindgenRustTriple = builtins.replaceStrings ["-"] ["_"] rustTriple;
      clangTriple = {
        "aarch64-linux-android" = "aarch64-linux-android26";
        "arm-linux-android" = "armv7a-linux-androideabi26";
        "x86_64-linux-android" = "x86_64-linux-android26";
      }.${triple};
      clang = "${ndkBin}/${clangTriple}-clang";
      sysroot = "${ndkRoot}/toolchains/llvm/prebuilt/linux-x86_64/sysroot";
    in mkBuild {
      pkgs = hostPkgs;
      buildTarget = triple;
      preferMusl = false;
      extraRustTargets = [ rustTriple ];
      skipZigIncludes = true;
      bindgenHook = false;
      includeGlfw = false;
      zigBuildFlags = [ "-Doptimize=ReleaseFast" "-Dmode=full" ];
      extraNativeBuildInputs = [ androidNdk ];
      extraInputs = {
        # bindgen's clang_macro_fallback spawns the clang executable, and the
        # nixpkgs clang wrapper injects host glibc include paths. With an
        # Android target that mixes host glibc headers into the parse, so set
        # the NDK args explicitly and point CLANG_PATH at unwrapped clang.
        preBuild = ''
          export BINDGEN_EXTRA_CLANG_ARGS="--target=${clangTriple} --sysroot=${sysroot}"
          export BINDGEN_EXTRA_CLANG_ARGS_${bindgenRustTriple}="--target=${clangTriple} --sysroot=${sysroot}"
        '';
      };
      extraEnv = {
        "CARGO_TARGET_${upperRustTriple}_LINKER" = clang;
        "CC_${bindgenRustTriple}" = clang;
        "AR_${bindgenRustTriple}" = "${ndkBin}/llvm-ar";
        "BINDGEN_EXTRA_CLANG_ARGS" = "--target=${clangTriple} --sysroot=${sysroot}";
        "BINDGEN_EXTRA_CLANG_ARGS_${bindgenRustTriple}" = "--target=${clangTriple} --sysroot=${sysroot}";
        "LIBCLANG_PATH" = "${hostPkgs.llvmPackages.libclang.lib}/lib";
        "CLANG_PATH" = "${hostPkgs.llvmPackages.clang-unwrapped}/bin/clang";
      };
    };

    # Outputs
    hostExtraInputs =
      if hostPkgs.stdenv.hostPlatform.isLinux then (linuxInputs { pkgs = hostPkgs; })
      else if hostPkgs.stdenv.hostPlatform.isWindows then (windowsInputs { pkgs = hostPkgs; })
      else {};

    packages = let
      crossPkgs = lib.genAttrs targetTriples mkCross;
      androidPkgs = lib.genAttrs androidTriples mkAndroid;
      allPkgs = crossPkgs // androidPkgs;
      defaultPkg = mkBuild {
        pkgs = hostPkgs;
        preferMusl = false;
        extraInputs = hostExtraInputs;
      };
      allPkg = hostPkgs.runCommand "z_wgpu_native-all" {} ''
        mkdir -p $out
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (name: pkg: ''
          ln -s ${pkg} $out/${name}
        '') allPkgs)}
      '';
    in allPkgs // {
      default = defaultPkg;
      cross-default = crossPkgs.${builtins.head targetTriples};
      android = androidPkgs."aarch64-linux-android";
      all = allPkg;
    };

    apps = {
      bundle = {
        type = "app";
        program = "${packages.default}/bin/default";
      };
      build   = env.app [] "zig build \"$@\"";
      test    = env.app [] "zig build test -Dtest=true -- \"$@\"";
      zig2nix = env.app [] "zig2nix \"$@\"";
    };

    devShells = {
      default = env.mkShell {
        buildInputs = with hostPkgs; [ python314Packages.lizard gdb zls ];
        nativeBuildInputs = with hostPkgs; []
          ++ packages.default.nativeBuildInputs
          ++ packages.default.buildInputs
          ++ packages.default.zigWrapperBins
          ++ packages.default.zigWrapperLibs;
        shellHook = ''
          export LIBCLANG_PATH=${hostPkgs.llvmPackages.libclang.lib}/lib
        '';
        postPatch = ''
          ln -s ${hostPkgs.callPackage ./build.zig.zon.nix { }} $ZIG_GLOBAL_CACHE_DIR/p
        '';
      };

      windows-tests = env.mkShell {
        nativeBuildInputs = packages.default.nativeBuildInputs
          ++ packages.default.buildInputs
          ++ packages.default.zigWrapperBins
          ++ packages.default.zigWrapperLibs
          ++ [ hostPkgs.wine64 ];
        shellHook = ''
          export WINEPREFIX="$PWD/.wine"
          export WINEDEBUG=-all
        '';
      };

      android = hostPkgs.mkShell {
        packages = [
          zig-bin
          androidRust
          androidNdk
          hostPkgs.llvmPackages.libclang.lib
          hostPkgs.pkg-config
        ];
        shellHook = ''
          export ANDROID_NDK_HOME=${ndkRoot}
          export ANDROID_NDK_ROOT=${ndkRoot}
          export LIBCLANG_PATH=${hostPkgs.llvmPackages.libclang.lib}/lib
          export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=${ndkBin}/aarch64-linux-android26-clang
          export CC_aarch64_linux_android=${ndkBin}/aarch64-linux-android26-clang
          export AR_aarch64_linux_android=${ndkBin}/llvm-ar
          export BINDGEN_EXTRA_CLANG_ARGS_aarch64_linux_android="--target=aarch64-linux-android26 --sysroot=${ndkRoot}/toolchains/llvm/prebuilt/linux-x86_64/sysroot"
          export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER=${ndkBin}/armv7a-linux-androideabi26-clang
          export CC_armv7_linux_androideabi=${ndkBin}/armv7a-linux-androideabi26-clang
          export AR_armv7_linux_androideabi=${ndkBin}/llvm-ar
          export BINDGEN_EXTRA_CLANG_ARGS_armv7_linux_androideabi="--target=armv7a-linux-androideabi26 --sysroot=${ndkRoot}/toolchains/llvm/prebuilt/linux-x86_64/sysroot"
          export CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER=${ndkBin}/x86_64-linux-android26-clang
          export CC_x86_64_linux_android=${ndkBin}/x86_64-linux-android26-clang
          export AR_x86_64_linux_android=${ndkBin}/llvm-ar
          export BINDGEN_EXTRA_CLANG_ARGS_x86_64_linux_android="--target=x86_64-linux-android26 --sysroot=${ndkRoot}/toolchains/llvm/prebuilt/linux-x86_64/sysroot"
        '';
      };
    };

  in {
    inherit packages apps devShells;
  }));
}
