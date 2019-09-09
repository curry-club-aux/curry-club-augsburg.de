{ nixpkgs ? import ./nixpkgs.nix }:

let
  pkgs = nixpkgs;

  default = import ./default.nix { pkgs = nixpkgs; };

  haskellPackages = default.haskellPackages;

in rec {
  siteGen = pkgs.haskell.lib.overrideCabal default.site (drv: {
    inherit (default) src;
    postPatch = (drv.postPatch or "") + ''
      find
      sed -i \
        -e "/unixFilter .*css.*/ s!css!$out/bin/css!" \
        curry-site.hs
    '';
  });

  hoogleEnv = haskellPackages.ghcWithHoogle (_: [ siteGen ]);

  site = pkgs.stdenv.mkDerivation {
    name = "curry-club-augsburg.de";
    inherit (default) src;
    buildInputs = [
      pkgs.glibcLocales
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
    doCheck = true;
    checkPhase = ''
      env LANG=de_DE.UTF-8 curry-site check --internal-links
    '';
  };

}
