# ══════════════════════════════════════════════════════════
#  User Packages
# ══════════════════════════════════════════════════════════
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # ── Development ──
    vscode
    nodejs
    python3

    # ── Browsers ──
    firefox

    # ── Media ──
    mpv           # Video player
    imv           # Image viewer (Wayland native)
    pavucontrol   # PulseAudio volume control GUI

    # ── Utilities ──
    btop          # System monitor (fancy)
    ripgrep       # Fast grep
    fd            # Fast find
    eza           # Modern ls replacement
    bat           # Cat with syntax highlighting
    fzf           # Fuzzy finder
    jq            # JSON processor
    p7zip         # Archive tool

    # ── Communication ──
    # discord
    # telegram-desktop

    # ── Wayland Tools ──
    wlsunset      # Night light / blue light filter
    cliphist      # Clipboard history
    wtype         # xdotool for Wayland
  ];
}
