{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          mlxOpenGL = pkgs.callPackage ./packages/opengl/mlx-macos-opengl.nix { };
          mlxMetal = pkgs.callPackage ./packages/metal/mlx-macos-metal.nix { };
        in {
          default = mlxOpenGL;
          mlx-opengl = mlxOpenGL;
          mlx-metal = mlxMetal;
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          mlxPackages = self.packages.${system};
        in {
          default = pkgs.mkShell {
            buildInputs = [ mlxPackages.mlx-opengl pkgs.zlib ];
          };
          metal = pkgs.mkShell {
            buildInputs = [ mlxPackages.mlx-metal pkgs.zlib ];
          };
        }
      );
    };
}
