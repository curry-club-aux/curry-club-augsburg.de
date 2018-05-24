with import <nixpkgs> {}; let

  srcFilter = path: type:
   let f = prefix: baseNameOf path != prefix;
   in lib.foldl' lib.and true (map f [ ".git" "_site" "_cache" "dist" ])
      && type != "symlink";
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
      find
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
