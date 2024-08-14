{
  description = "Flake for building a Qt GUI program";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      coreLib = pkgs.callPackage ./src/core/default.nix {};
      guiApp = pkgs.callPackage ./src/GUI/default.nix {
          inherit coreLib;
        };
    in{
      apps.${system}.default = {
        type = "app";
        program = "${guiApp}/bin/gui_program";
      };
    devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.gdb
          pkgs.gtkmm4
          # Add other required Qt modules here
          coreLib.buildInputs
          guiApp.buildInputs
        ];
        nativeBuildInputs = [
          pkgs.cmake
          pkgs.pkg-config
          pkgs.clang_18
        ];
        shellHook = ''
          # Create a build dir. This allows the LSP to see compile_comands
          echo DEV Console starting...
          echo Creating build dir, allows LSP to find compile_comands

          mkdir -p build
          cmake -S . -B build
        '';
      };
    };
}
