{ 
  stdenv,
  cmake,
  lib,
  pkg-config,
  qt5Full,
  qt5,
  callPackage,
  clang_18,
  coreLib,
  gtkmm4,
  ...
}:
let
  project_name = "gui_program";
  build_type = "Debug";
in
stdenv.mkDerivation {
  pname = "${project_name}";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ cmake pkg-config clang_18];

  buildInputs = [
    gtkmm4
    coreLib
  ];

  configurePhase = ''
    ls

    cmake -B cmake-build -S .

    cd cmake-build

    cmake -DCMAKE_BUILD_TYPE=${build_type} \
    -DPACKAGE_NAME=${project_name} \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=YES ..

    mkdir -p $out/
    cp compile_commands.json $out/
  '';

  buildPhase = ''
    cmake --build .
  '';

  installPhase = ''
    cmake --install . --prefix $out
  '';

}
