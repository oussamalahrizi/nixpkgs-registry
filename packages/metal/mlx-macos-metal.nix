{
  stdenv,
  swift,
  zlib,
  fetchurl,
}:

stdenv.mkDerivation {
  # Preserve flag-list entries as separate arguments, including embedded spaces.
  __structuredAttrs = true;

  pname = "mlx-macos-metal";
  version = "1.0";

  src = fetchurl {
    url = "https://github.com/oussamalahrizi/nixpkgs-registry/releases/download/mlx-v1/mlx-macos-metal.tgz";
    sha256 = "6ef2e04be2e6a3aa360bf9dfee11c5ed29a57177827e1f65d98188fa5035cb6c";
  };
  dontConfigure = true; # no need to search for configure script
  nativeBuildInputs = [ swift ];
  buildInputs = [ zlib ];
  installFlags = [ "OUTPUT=$(out)" ];
  # makeFlags passes arguments to make during both the build and install phases
  makeFlags = [
    "OPTI=-target ${stdenv.hostPlatform.swift.triple}"
  ];
}
