let
  # 2019-09-08 (19.09 release branch)
  rev = "0d79decdb3ba7da459aafb002745a10bb97141bb";
  nixpkgs = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = "0rjwmy778mzp845lap10vfrshm3llhavri889qq7khn58wxvazq5";
  }) {};
  hp = nixpkgs.haskellPackages.override {
    overrides = self: super: {
      clay = nixpkgs.haskell.lib.overrideCabal super.clay
        (drv: { broken = false; jailbreak = true; });
      site = super.callPackage ./site.nix {};
      siteEnv = with self;
        (nixpkgs.haskell.lib.addBuildTools self.site
          [ ghcid cabal-install ]).env;
     };
  };
in
  hp
