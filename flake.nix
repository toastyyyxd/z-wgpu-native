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
      env = zig2nix.outputs.zig-env.${system} { zig = zig2nix.outputs.packages.${system}.zig-master; };
      zls = zls-overlay.packages.${system}.zls;
      hostPkgs = env.pkgs;
      inherit (hostPkgs) lib;

    in with builtins; with lib; rec {
      zigToRustTriple = {
        "x86_64-linux-musl" = "x86_64-unknown-linux-musl";
        "aarch64-linux-musl" = "aarch64-unknown-linux-musl";
        "x86_64-windows-gnu" = "x86_64-pc-windows-gnu";
        "aarch64-windows-gnu" = "aarch64-pc-windows-gnullvm";
      };

      linuxInputs = { pkgs }: {
        buildInputs = with pkgs; [
          libx11 libxrandr libxinerama
          libxi libxcursor libxext
          libxxf86vm libxkbcommon
          wayland wayland-protocols
        ];
      };
      windowsInputs = { pkgs }: {
        clang = hostPkgs.writeScriptBin "clang" ''
        #!/bin/sh
        exec ${hostPkgs.llvmPackages.clang-unwrapped}/bin/clang \
          -isystem ${hostPkgs.pkgsCross.mingwW64.stdenv.cc.libc.dev}/include \
          "$@"
        '';
        zigBuildFlags = [ "-fwine" ];
        buildInputs = with pkgs; [
          pkgsCross.mingwW64.windows.mingw_w64
          pkgsCross.mingwW64.windows.mingw_w64_headers
          pkgsCross.mingwW64.windows.pthreads
        ];
        nativeBuildInputs = with hostPkgs; [
          wineWow64Packages.stable fontconfig
        ];
        env = {
          FONTCONFIG_FILE = pkgs.makeFontsConf {
            fontDirectories = [ pkgs.dejavu_fonts ];
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
      
      mkBuild = {
        pkgs,                     # nixpkgs instance (host or cross)
        crossTarget ? null,       # optional triple, e.g. "x86_64-linux-musl"
        preferMusl ? true,
        wrapperBins ? [],
        wrapperLibs ? [],
        wrapperArgs ? [],
        extraEnv ? {},
        zigBuildFlags ? [ "-Doptimize=ReleaseFast" ],
        extraBuildInputs ? [],
        extraNativeBuildInputs ? [],
        extraInputs ? {},
      }: let
        isCross = crossTarget != null;
        zigTarget = if isCross then (env.target crossTarget).zig else null;

        rustTriple = if isCross then zigToRustTriple.${crossTarget} else pkgs.stdenv.hostPlatform.rust.rustcTarget;

        rust-bin = rust-overlay.lib.mkRustBin {} pkgs.buildPackages;
        rustToolchain = rust-bin.stable.latest.default.override {
          targets = [ rustTriple ];
        };

        upperRustTriple = toUpper (replaceStrings ["-"] ["_"] rustTriple);
        cargoEnv = lib.optionalAttrs isCross {
          "CARGO_TARGET_${upperRustTriple}_LINKER" = "${pkgs.stdenv.cc.targetPrefix}cc";
        };

        buildInputs = with pkgs; [
          glfw
        ] ++ extraBuildInputs ++ (extraInputs.buildInputs or []);
        
        nativeBuildInputs = with pkgs.buildPackages; [
          rustToolchain
          llvmPackages.libclang.lib
          rustPlatform.cargoSetupHook
        ] ++ [ (extraInputs.clang or hostPkgs.llvmPackages.clang) ] ++ extraNativeBuildInputs ++ (extraInputs.nativeBuildInputs or []);
        
        finalEnv = {
          LIBCLANG_PATH = "${pkgs.buildPackages.llvmPackages.libclang.lib}/lib";
        } // cargoEnv // extraEnv // (extraInputs.env or {});

      in env.package {
        src = cleanSource ./.;
        zigTarget = zigTarget;
        zigBuildFlags = zigBuildFlags ++ (extraInputs.zigBuildFlags or []);
        zigPreferMusl = preferMusl;
        zigWrapperBins = wrapperBins;
        zigWrapperLibs = wrapperLibs;
        zigWrapperArgs = wrapperArgs;
        nativeBuildInputs = nativeBuildInputs;
        buildInputs = buildInputs;
        env = finalEnv;
        cargoRoot = "vendor/wgpu-native";
        cargoDeps = hostPkgs.rustPlatform.importCargoLock {
          lockFile = ./vendor/wgpu-native/Cargo.lock;
        };
        preBuild = extraInputs.preBuild or "";
      };

      hostExtraInputs =
        if hostPkgs.stdenv.isLinux then (linuxInputs { pkgs = hostPkgs; })
        else if hostPkgs.stdenv.isWindows then (windowsInputs { pkgs = hostPkgs; })
        else null;

      packages.foreign = mkBuild {
        pkgs = hostPkgs;
        preferMusl = true;
        extraInputs = hostExtraInputs;
      };

      packages.default = mkBuild {
        pkgs = hostPkgs;
        preferMusl = false;
        extraInputs = hostExtraInputs;
      };

      targetTriples = [
        "x86_64-linux-musl"
        "aarch64-linux-musl"
        "x86_64-windows-gnu"
        "aarch64-windows-gnu"
      ];

      mkCross = triple: let
        crossPkgs = env.pkgsForTarget triple;
      in mkBuild {
        pkgs = crossPkgs;
        crossTarget = triple;
        preferMusl = true;      # note this only applies for linux, otherwise ignored, afaik
        extraInputs = { clang = hostPkgs.llvmPackages.clang-unwrapped; } //
          (if hasInfix "linux" triple then linuxInputs { pkgs = crossPkgs; }
          else if hasInfix "windows" triple then windowsInputs { pkgs = crossPkgs; }
          else null);
      };

      packages.cross = lib.genAttrs targetTriples mkCross;
      packages.cross-default = packages.cross.${head targetTriples};

      apps.bundle = {
        type = "app";
        program = "${packages.foreign}/bin/default";
      };

      apps.default = env.app [] "zig build run -- \"$@\"";
      apps.build = env.app [] "zig build \"$@\"";
      apps.test = env.app [] "zig build test -- \"$@\"";
      apps.docs = env.app [] "zig build docs -- \"$@\"";
      apps.zig2nix = env.app [] "zig2nix \"$@\"";

      devShells.default = env.mkShell {
        buildInputs = with hostPkgs; [ python314Packages.lizard gdb ] ++ [ zls ];
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
    }));
}
