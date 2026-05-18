{
  description = "NixOS Configuration with Niri + Noctalia Shell (flake-parts)";

  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri compositor
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia Shell
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # Supported systems
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [
        ./flake-modules/nixos.nix
      ];

      # Per-system outputs (devShells, packages, etc.)
      perSystem = { pkgs, ... }: {
        # Dev shell for working on this config
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nil        # Nix LSP
            nixfmt-rfc-style
          ];
        };
      };
    };
}
