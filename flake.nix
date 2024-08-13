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
      packages.${system}.default = pkgs.buildEnv {
        name = "combinedEnv";
        paths = [ guiApp ];  # Include the packages in the environment
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
        '';
      };
    };
}
