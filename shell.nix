with (import <nixpkgs> {}).pkgs.haskellngPackages;
(callPackage (import ./default.nix) { extraDeps = [ cabal-install ]; }).env
