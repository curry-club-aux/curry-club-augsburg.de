let 
nixpkgs = import <nixpkgs> {};
haskellNg = nixpkgs.pkgs.haskell-ng;
# hopefully temporary, but ghc 7.8 fails because of non-deterministic builds (of GHC)
ghc710 = haskellNg.packages.ghc7101;
# Fix for unnecessary patches 7.10 wants to apply see https://github.com/NixOS/nixpkgs/commit/f65fed20deea43096528f87cc94ef6943adc0b37
ownHakyll = with nixpkgs.pkgs.haskellPackages; callPackage (import ./hakyll-tmp.nix) {};
pkg = with ghc710; callPackage ./. { hakyll = ownHakyll; };
ghc = ghc710.ghcWithPackages (pkgs: with pkgs; [ base clay directory ownHakyll text system-filepath ]);

in
with nixpkgs.lib;
overrideDerivation pkg (super: {
  buildInputs = super.buildInputs ++ [ ghc ghc710.cabal-install];
})
