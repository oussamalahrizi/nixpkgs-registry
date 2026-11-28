{
  stdenv,
  fetchurl,
  zlib,
}:
# nix runs these steps for making this package:
# ./configure, make, make install
# stdenv provides the compiler and make; Apple frameworks are handled separately.
stdenv.mkDerivation {
  pname = "mlx-macos-opengl";
  version = "1.0";
  src = fetchurl {
    url = "https://github.com/oussamalahrizi/nixpkgs-registry/releases/download/mlx-v1/mlx-macos-opengl.tgz";
    sha256 = "95390cf53bec8947c8f8017236684f36dca416b48c7e512fea35e386322b3819";
  };
  buildInputs = [ zlib ];
  dontConfigure = true; # no need to search for configure script
  installFlags = ["OUTPUT=$(out)"];
}
