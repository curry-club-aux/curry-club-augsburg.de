{ mkDerivation, base, hakyll, stdenv }:
mkDerivation {
  pname = "haskell-augsburg-de";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  buildDepends = [ base hakyll ];
  license = stdenv.lib.licenses.cc-by-sa-30;
}
