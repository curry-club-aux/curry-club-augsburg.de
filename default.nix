let
  nixpkgs = import <nixpkgs> {};
  hp = nixpkgs.haskellPackages.override {
    overrides = self: super: {
      site = super.callPackage ./site.nix {};
      siteEnv = with self;
        (nixpkgs.haskell.lib.addBuildTools self.site
          [ ghcid cabal-install ]).env;
     };
  };
in
  hp
