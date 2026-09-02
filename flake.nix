{
  description = "C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
    in
      nixpkgs.lib.genAttrs systems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              gcc
              clang-tools
              cmake
              gdb
            ];

            shellHook = ''
              export CC=gcc
              export CXX=g++
            '';
          };
        }
      );
}
