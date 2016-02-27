with import <nixpkgs> {}; let

  srcFilter = path: type: baseNameOf path != "git" && type != "symlink";
  src = builtins.filterSource srcFilter ./.;

  unpatchedSiteGen = haskellPackages.callPackage (import ./default.nix) {};

in rec {
  siteGen = haskell.lib.overrideCabal unpatchedSiteGen (drv: {
    inherit src;
    postPatch = (drv.postPatch or "") + ''
      sed -i \
        -re 's!(unixFilter *")cabal(" *\[)[^]]*(\])!\1'"$out/bin/css"'\2\3!' \
        site.hs
    '';
  });

  site = with import <nixpkgs> {}; stdenv.mkDerivation {
    name = "curry-club-augsburg.de";
    inherit src;
    buildInputs = [ glibcLocales ];
    buildPhase = "LANG=de_DE.UTF-8 ${siteGen}/bin/site build";
    installPhase = ''
      mv _site "$out"
      mkdir -p "$out/nix-support"
      echo "website website $out/index.html" \
        > "$out/nix-support/hydra-build-products"
    '';
  };
}
