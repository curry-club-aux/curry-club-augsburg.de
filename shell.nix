let 
nixpkgs = import <nixpkgs> {};
haskellNg = nixpkgs.pkgs.haskell-ng;
# hopefully temporary, but ghc 7.8 fails because of non-deterministic builds (of GHC)
ghc710 = haskellNg.packages.ghc7101;
fixedHakyll = ghc710.hakyll.override { inherit (ghc710) mkDerivation; };
pkg = ghc710.callPackage ./. {
  hakyll = haskellNg.lib.dontCheck fixedHakyll;
};

in
nixpkgs.lib.overrideDerivation pkg.env (old: {
  buildInputs = old.buildInputs ++ [ ghc710.cabal-install ];
})
