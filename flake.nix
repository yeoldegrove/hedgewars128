{
  description = "Hedgewars with 128 teams/players support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hedgewars128 = import ./hedgewars128.nix { inherit pkgs; };
      in
      {
        packages = {
          default = hedgewars128;
          hedgewars128 = hedgewars128;
        };

        apps = {
          default = {
            type = "app";
            program = "${hedgewars128}/bin/hedgewars";
          };
          hedgewars = {
            type = "app";
            program = "${hedgewars128}/bin/hedgewars";
          };
          hwengine = {
            type = "app";
            program = "${hedgewars128}/bin/hwengine";
          };
          hedgewars-server = {
            type = "app";
            program = "${hedgewars128}/bin/hedgewars-server";
          };
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ hedgewars128 ];
          packages = with pkgs; [
            gdb
            valgrind
            git
          ];
          shellHook = ''
            echo "Hedgewars 128-team development environment"
            echo "  nix build  - Build Hedgewars with 128 team support"
            echo "  nix run    - Run the game"
          '';
        };
      }
    );
}
