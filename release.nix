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
    buildInputs = [
      glibcLocales
      (haskellPackages.ghcWithPackages (hp: [ hp.cabal-install ]))
      siteGen
    ];
    buildPhase = ''
      env LANG=de_DE.UTF-8 \
          backend=inpath \
          HOME=$(mktemp -d) \
          curry-site build
      '';
    installPhase = ''
      mv _site "$out"
      mkdir -p "$out/nix-support"
      echo "website website $out/index.html" \
        > "$out/nix-support/hydra-build-products"
    '';
  };

}
