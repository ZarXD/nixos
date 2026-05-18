# Home Manager entry point
{ config, pkgs, inputs, ... }:

{
  imports = [
    # Noctalia Shell home module
    inputs.noctalia.homeModules.default

    # Niri, Noctalia, dan app configs
    ./niri.nix
    ./noctalia.nix
    ./shell.nix
    ./packages.nix
    ./gtk.nix
  ];

  home = {
    # ── Ganti dengan username kamu ──
    username = "user";
    homeDirectory = "/home/user";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
