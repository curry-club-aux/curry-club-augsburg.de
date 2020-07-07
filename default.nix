{ pkgs ? import ./nixpkgs.nix {} }:
let
  src = pkgs.nix-gitignore.gitignoreSource [".git/" "*.nix"] ./.;

  generatedNix = pkgs.runCommand "curry-club-default.nix" {}
    ''
      # yeah, because cabal2nix is, like, the worst
      cp -r ${src}/* .
      cp -r ${builtins.path { path = ./.git; name = "dotgit"; }} .git

      ${pkgs.cabal2nix}/bin/cabal2nix . > $out
      sed -e 's|src = ./.|src = ${src}|' -i $out
    '';

  hp = pkgs.haskellPackages.override {
    overrides = self: super: {

      clay = pkgs.haskell.lib.overrideCabal super.clay
        (drv: { broken = false; jailbreak = true; });

      site = super.callPackage generatedNix {};

      siteEnv = with self;
        (pkgs.haskell.lib.addBuildTools self.site
          [ ghcid cabal-install ]).env;

     };
  };
in {
    _a = abort "don’t build this, use `-A site`";
    inherit src;
    inherit (hp) site siteEnv;
    haskellPackages = hp;
}
