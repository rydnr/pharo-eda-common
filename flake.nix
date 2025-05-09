{
  description = "Flake for rydnr/pharo-eda-common";

  inputs = rec {
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    rydnr-nix-flakes-pharo-vm = {
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:rydnr/nix-flakes/pharo-vm-12.0.1519.4?dir=pharo-vm";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        org = "rydnr";
        repo = "pharo-eda-common";
        pname = "${repo}";
        tag = "0.1.2";
        baseline = "PharoEDACommon";
        pkgs = import nixpkgs { inherit system; };
        description = "Classes shared among PharoEDA components.";
        license = pkgs.lib.licenses.gpl3;
        homepage = "https://github.com/rydnr/pharo-eda-common";
        maintainers = with pkgs.lib.maintainers; [ ];
        nixpkgsVersion = builtins.readFile "${nixpkgs}/.version";
        nixpkgsRelease =
          builtins.replaceStrings [ "\n" ] [ "" ] "nixpkgs-${nixpkgsVersion}";
        shared = import ./nix/shared.nix;
        pharo-eda-common-for = { bootstrap-image-name, bootstrap-image-sha256, bootstrap-image-url, pharo-vm }:
          let
            bootstrap-image = pkgs.fetchurl {
              url = bootstrap-image-url;
              sha256 = bootstrap-image-sha256;
            };
            neojson = pkgs.fetchgit {
              url = "https://github.com/svenvc/neojson";
              rev = "v18";
              sha256 = "sha256-lzcH2ea83993/H3+Mi4z8FW/Wd9VvFH08bp4kAAu8+Q=";
              leaveDotGit = true;
            };
            src = ./src;
          in pkgs.stdenv.mkDerivation (finalAttrs: {
            version = tag;
            inherit pname src;

            strictDeps = true;

            buildInputs = with pkgs; [
              neojson
            ];

            nativeBuildInputs = with pkgs; [
              pharo-vm
              pkgs.unzip
            ];

            unpackPhase = ''
              unzip -o ${bootstrap-image} -d image
              cp -r ${src} src
              mkdir -p $out/share/src/${pname}
              cp -r ${neojson}/repository $out/share/src/neojson
            '';

            configurePhase = ''
              runHook preConfigure

              substituteInPlace src/BaselineOfPharoEDACommon/BaselineOfPharoEDACommon.class.st \
                --replace-fail "github://svenvc/NeoJSON/repository" "filetree://$out/share/src/neojson"
              # load baseline
              ${pharo-vm}/bin/pharo image/${bootstrap-image-name} eval --save "EpMonitor current disable. NonInteractiveTranscript stdout install. [ Metacello new repository: 'tonel://$PWD/src'; baseline: '${baseline}'; onConflictUseLoaded; load ] ensure: [ EpMonitor current enable ]"

              runHook postConfigure
            '';

            buildPhase = ''
              runHook preBuild

              # assemble
              ${pharo-vm}/bin/pharo image/${bootstrap-image-name} save "${pname}"

              mkdir dist
              mv image/${pname}.* dist/

              runHook postBuild
            '';

            installPhase = ''
              runHook preInstall

              mkdir -p $out
              cp -r ${pharo-vm}/bin $out
              cp -r ${pharo-vm}/lib $out
              cp -r dist/* $out/
              cp image/*.sources $out/
              pushd src
              cp -r . $out/share/src/${pname}
              ${pkgs.zip}/bin/zip -r $out/share/${pname}.zip .
              popd
              pushd ${neojson}/repository
              ${pkgs.zip}/bin/zip -r $out/share/neojson.zip .
              popd

              runHook postInstall
             '';

            meta = {
              changelog = "https://github.com/rydnr/pharo-eda-common/releases/";
              longDescription = ''
                    This repository contains classes shared among PharoEDA components.
              '';
              inherit description homepage license maintainers;
              mainProgram = "pharo";
              platforms = pkgs.lib.platforms.linux;
            };
        });
      in rec {
        defaultPackage = packages.default;
        devShells = rec {
          default = pharo-eda-common-12;
          pharo-eda-common-12 = shared.devShell-for {
            package = packages.pharo-eda-common-12;
            inherit org pkgs repo tag;
            nixpkgs-release = nixpkgsRelease;
          };
        };
        packages = rec {
          default = pharo-eda-common-12;
          pharo-eda-common-12 = pharo-eda-common-for rec {
            bootstrap-image-url = rydnr-nix-flakes-pharo-vm.resources.${system}.bootstrap-image-url;
            bootstrap-image-sha256 = rydnr-nix-flakes-pharo-vm.resources.${system}.bootstrap-image-sha256;
            bootstrap-image-name = rydnr-nix-flakes-pharo-vm.resources.${system}.bootstrap-image-name;
            pharo-vm = rydnr-nix-flakes-pharo-vm.packages.${system}.pharo-vm;
          };
        };
      });
}
