# Main system configuration
{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./nvidia.nix  # ← UNCOMMENT ini di laptop asli (NVIDIA RTX 3050)!
  ];

  # ══════════════════════════════════════════
  #  Boot
  # ══════════════════════════════════════════
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # ══════════════════════════════════════════
  #  Networking
  # ══════════════════════════════════════════
  networking = {
    hostName = "nightraven";
    networkmanager.enable = true;
  };

  # ══════════════════════════════════════════
  #  Locale & Timezone
  # ══════════════════════════════════════════
  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  # ══════════════════════════════════════════
  #  Niri Compositor
  # ══════════════════════════════════════════
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;  # Pakai dari nixpkgs cache, biar gak compile

  # Niri sudah otomatis setup:
  # - polkit (+ KDE polkit agent)
  # - xdg-desktop-portal-gnome
  # - GNOME keyring
  # - dconf, opengl, default fonts
  # - pam entry untuk swaylock

  # ══════════════════════════════════════════
  #  Graphics
  # ══════════════════════════════════════════

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ══════════════════════════════════════════
  #  Display Manager (greetd + tuigreet)
  # ══════════════════════════════════════════
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # ══════════════════════════════════════════
  #  Audio (PipeWire)
  # ══════════════════════════════════════════
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # ══════════════════════════════════════════
  #  User
  # ══════════════════════════════════════════
  users.users.heyiza = {
    isNormalUser = true;
    description = "Heyiza";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.fish;
  };

  # ══════════════════════════════════════════
  #  System Packages
  # ══════════════════════════════════════════
  environment.systemPackages = with pkgs; [
    # Core utilities
    git
    wget
    curl
    unzip
    htop
    neovim

    # Wayland essentials
    wl-clipboard         # Clipboard manager
    xdg-utils            # xdg-open, etc.
    libnotify            # notify-send

    # Niri companion apps
    fuzzel               # Application launcher
    swaylock-effects     # Lock screen
    grim                 # Screenshot utility
    slurp                # Region selector
    swappy               # Screenshot editor
    brightnessctl        # Brightness control
    playerctl            # Media control
    pamixer              # Volume control

    # File manager
    nautilus

    # Terminal
    alacritty
  ];

  # ══════════════════════════════════════════
  #  Fonts
  # ══════════════════════════════════════════
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" "Noto Sans" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # ══════════════════════════════════════════
  #  Programs
  # ══════════════════════════════════════════
  programs.fish.enable = true;

  # ══════════════════════════════════════════
  #  Nix Settings
  # ══════════════════════════════════════════
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # Niri binary cache
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
