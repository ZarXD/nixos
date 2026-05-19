# Home Manager entry point
{ config, pkgs, inputs, ... }:

{
  imports = [
    # Noctalia Shell home module — uncomment kalau sudah confirmed working
    # inputs.noctalia.homeModules.default

    # Niri, Noctalia, dan app configs
    ./niri.nix
    # ./noctalia.nix  # depends on noctalia module above
    ./shell.nix
    ./packages.nix
    ./gtk.nix
  ];

  home = {
    # ── Ganti dengan username kamu ──
    username = "heyiza";
    homeDirectory = "/home/heyiza";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
