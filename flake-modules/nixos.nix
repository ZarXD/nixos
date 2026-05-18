# flake-parts module: NixOS configurations
{ inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      nightraven = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Hardware (generate via nixos-generate-config)
          ../hosts/default/hardware-configuration.nix

          # System configuration
          ../hosts/default/configuration.nix

          # Niri NixOS module (polkit, portal, keyring, dll)
          inputs.niri.nixosModules.niri

          # Home Manager as NixOS module
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              # ── Ganti "user" dengan username kamu ──
              users.user = import ../home;
            };
          }
        ];
      };
    };
  };
}
