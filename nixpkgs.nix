# 2019-09-08 (19.09 release branch)
let rev = "0d79decdb3ba7da459aafb002745a10bb97141bb";
in import (fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
  sha256 = "0rjwmy778mzp845lap10vfrshm3llhavri889qq7khn58wxvazq5";
}) {}
