# ══════════════════════════════════════════════════════════
#  Noctalia Shell Configuration
# ══════════════════════════════════════════════════════════
#
#  Noctalia Shell adalah Wayland-native desktop shell yang
#  dibangun di atas Quickshell (Qt/QML). Menyediakan:
#  - Status bar / panel
#  - Dock
#  - Notifications
#  - Control center
#  - OSD (On-Screen Display)
#  - Lock screen widgets
#
#  Compositor support: Niri, Hyprland, Sway, Scroll, Labwc
#
#  Dokumentasi lengkap: https://docs.noctalia.dev/
# ══════════════════════════════════════════════════════════
{ config, pkgs, inputs, ... }:

{
  # Enable Noctalia Shell (imported via homeModules.default di default.nix)
  programs.noctalia-shell = {
    enable = true;

    # Konfigurasi Noctalia bisa diatur di sini secara declarative,
    # atau melalui GUI settings bawaan Noctalia:
    #   - Klik kanan pada bar → Settings
    #   - Atau buka Control Center
    #
    # Setelah kustomisasi via GUI, kamu bisa export settings ke JSON
    # lalu import kembali ke sini untuk reproducibility.
    settings = {
      # Contoh settings (sesuaikan dengan preferensi kamu):
      # bar = {
      #   position = "top";
      #   height = 36;
      #   opacity = 0.9;
      # };
      # theme = {
      #   colorScheme = "dark";
      #   accentColor = "#7aa2f7";
      # };
    };
  };

  # Dependencies yang dibutuhkan Noctalia
  home.packages = with pkgs; [
    swaybg        # Wallpaper setter (dipakai di niri spawn-at-startup)
    mako          # Fallback notification daemon (opsional, Noctalia punya built-in)
  ];
}
