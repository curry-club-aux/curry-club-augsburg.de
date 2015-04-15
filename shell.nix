with (import <nixpkgs> {}).pkgs;
let pkg = haskellngPackages.callPackage (import ./default.nix) {};
in pkg.env
