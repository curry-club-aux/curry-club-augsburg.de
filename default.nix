let
  nixpkgs = import <nixpkgs> {};
  hp = nixpkgs.haskell.packages.ghc7103.override {
    overrides = self: super: {
      site = super.callPackage ./site.nix {};
      siteEnv = with self;
        (nixpkgs.haskell.lib.addBuildTools self.site
          [ ghcid cabal-install nixpkgs.stack ]).env;
     };
  };
in
  hp
