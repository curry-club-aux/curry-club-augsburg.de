with import <nixpkgs> {}; let

  srcFilter = path: type: baseNameOf path != ".git" && type != "symlink";
  src = builtins.filterSource srcFilter ./.;

  pkg = pkgs.runCommand "curry-club-default.nix" { src = ./.; } ''
    ${pkgs.cabal2nix}/bin/cabal2nix $src > $out
  '';

  haskellPackages = pkgs.haskellPackages;

  unpatchedSiteGen = haskellPackages.callPackage (import pkg) {};

in rec {
  siteGen = haskell.lib.overrideCabal unpatchedSiteGen (drv: {
    inherit src;
    postPatch = (drv.postPatch or "") + ''
      sed -i \
        -e "/unixFilter .*css.*/ s!css!$out/bin/css!" \
        curry-site.hs
    '';
  });
  hoogleEnv = haskellPackages.ghcWithHoogle (_: [ siteGen ]);

  site = with import <nixpkgs> {}; stdenv.mkDerivation {
    name = "curry-club-augsburg.de";
    inherit src;
    buildInputs = [ glibcLocales ];
    buildPhase = "LANG=de_DE.UTF-8 ${siteGen}/bin/curry-site build";
    installPhase = ''
      mv _site "$out"
      mkdir -p "$out/nix-support"
      echo "website website $out/index.html" \
        > "$out/nix-support/hydra-build-products"
    '';
  };

}
