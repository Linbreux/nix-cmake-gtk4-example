{ 
  stdenv,
  cmake,
  pkg-config,
  lib,
  ...
}:

let
  library_name = "core";
  build_type = "Debug";
in
stdenv.mkDerivation {
  pname = "${library_name}";
  version = "1.0.0";

  outputs = [ "lib" "dev" "out" ];

  src = ./.;

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [];

  configurePhase = ''
    mkdir -p $lib/lib
    mkdir -p $dev/include

    cmake -DCMAKE_BUILD_TYPE=${build_type} \
          -DNIX_LIBRARY_NAME=${library_name} \
          -DCMAKE_EXPORT_COMPILE_COMMANDS=YES \
          -DCMAKE_INSTALL_LIBDIR=$lib/lib \
          -DCMAKE_INSTALL_INCLUDEDIR=$dev/include \
          -DCMAKE_INSTALL_PREFIX=$out \
          .
  '';

  buildPhase = ''
    cmake --build .
  '';

  installPhase = ''
    mkdir -p $out
    cmake --install . --prefix $out
  '';

  meta = {
    description = "Core C++ library";
    license = lib.licenses.mit;
  };
}

