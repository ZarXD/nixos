# ══════════════════════════════════════════════════════════
#  Niri Configuration (declarative via niri-flake)
# ══════════════════════════════════════════════════════════
{ config, pkgs, inputs, ... }:

{
  programs.niri.settings = {

    # ── Input ──────────────────────────────────────────────
    input = {
      keyboard.xkb.layout = "us";

      touchpad = {
        tap = true;
        dwt = true;     # disable-while-typing
        natural-scroll = true;
        accel-speed = 0.2;
      };

      mouse = {
        accel-speed = 0.0;
      };

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };
    };

    # ── Layout ─────────────────────────────────────────────
    layout = {
      gaps = 8;
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];

      default-column-width = {
        proportion = 1.0 / 2.0;
      };

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#7aa2f7";   # Tokyo Night blue
        inactive.color = "#565f89"; # Tokyo Night muted
      };

      border = {
        enable = false;
      };

      struts = {
        # left = 0;
        # right = 0;
        # top = 0;
        # bottom = 0;
      };
    };

    # ── Spawn at Startup ──────────────────────────────────
    spawn-at-startup = [
      # Noctalia Shell (bar, dock, notifications, dll)
      { command = [ "noctalia-qs" "-c" "noctalia-shell" ]; }

      # Wallpaper — ganti path sesuai selera
      { command = [ "swaybg" "-i" "${config.home.homeDirectory}/wallpapers/wallpaper.jpg" "-m" "fill" ]; }
    ];

    # ── Prefer no CSD ─────────────────────────────────────
    prefer-no-csd = true;

    # ── Screenshot ────────────────────────────────────────
    screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H-%M-%S.png";

    # ── Animations ────────────────────────────────────────
    animations = {
      slowdown = 1.0;
    };

    # ── Window Rules ──────────────────────────────────────
    window-rules = [
      # Contoh: floating window untuk dialog
      {
        matches = [{ app-id = "^org\\.gnome\\."; }];
        # default-column-width = { proportion = 0.5; };
      }
    ];

    # ── Keybindings ───────────────────────────────────────
    binds = let
      a = config.lib.niri.actions;
    in {
      # ─── Essentials ───
      "Mod+Return".action    = a.spawn "alacritty";
      "Mod+D".action         = a.spawn "fuzzel";
      "Mod+Shift+Q".action   = a."close-window";
      "Mod+Shift+E".action   = a.quit;
      "Mod+Shift+Slash".action = a."show-hotkey-overlay";

      # ─── Screenshots ───
      "Print".action         = a.screenshot;
      "Mod+Print".action     = a."screenshot-screen";
      "Mod+Shift+Print".action = a."screenshot-window";

      # ─── Focus ───
      "Mod+H".action         = a."focus-column-left";
      "Mod+L".action         = a."focus-column-right";
      "Mod+J".action         = a."focus-window-down";
      "Mod+K".action         = a."focus-window-up";
      "Mod+Left".action      = a."focus-column-left";
      "Mod+Right".action     = a."focus-column-right";
      "Mod+Down".action      = a."focus-window-down";
      "Mod+Up".action        = a."focus-window-up";

      # ─── Move Windows ───
      "Mod+Shift+H".action   = a."move-column-left";
      "Mod+Shift+L".action   = a."move-column-right";
      "Mod+Shift+J".action   = a."move-window-down";
      "Mod+Shift+K".action   = a."move-window-up";
      "Mod+Shift+Left".action  = a."move-column-left";
      "Mod+Shift+Right".action = a."move-column-right";
      "Mod+Shift+Down".action  = a."move-window-down";
      "Mod+Shift+Up".action    = a."move-window-up";

      # ─── Workspaces ───
      "Mod+1".action         = a."focus-workspace" 1;
      "Mod+2".action         = a."focus-workspace" 2;
      "Mod+3".action         = a."focus-workspace" 3;
      "Mod+4".action         = a."focus-workspace" 4;
      "Mod+5".action         = a."focus-workspace" 5;
      "Mod+6".action         = a."focus-workspace" 6;
      "Mod+7".action         = a."focus-workspace" 7;
      "Mod+8".action         = a."focus-workspace" 8;
      "Mod+9".action         = a."focus-workspace" 9;

      "Mod+Shift+1".action   = a."move-column-to-workspace" 1;
      "Mod+Shift+2".action   = a."move-column-to-workspace" 2;
      "Mod+Shift+3".action   = a."move-column-to-workspace" 3;
      "Mod+Shift+4".action   = a."move-column-to-workspace" 4;
      "Mod+Shift+5".action   = a."move-column-to-workspace" 5;
      "Mod+Shift+6".action   = a."move-column-to-workspace" 6;
      "Mod+Shift+7".action   = a."move-column-to-workspace" 7;
      "Mod+Shift+8".action   = a."move-column-to-workspace" 8;
      "Mod+Shift+9".action   = a."move-column-to-workspace" 9;

      "Mod+Page_Down".action = a."focus-workspace-down";
      "Mod+Page_Up".action   = a."focus-workspace-up";
      "Mod+Shift+Page_Down".action = a."move-column-to-workspace-down";
      "Mod+Shift+Page_Up".action   = a."move-column-to-workspace-up";

      # ─── Column Width ───
      "Mod+R".action         = a."switch-preset-column-width";
      "Mod+F".action         = a."maximize-column";
      "Mod+Shift+F".action   = a."fullscreen-window";
      "Mod+Minus".action     = a."set-column-width" "-10%";
      "Mod+Equal".action     = a."set-column-width" "+10%";

      # ─── Consume / Expel ───
      "Mod+BracketLeft".action  = a."consume-window-into-column";
      "Mod+BracketRight".action = a."expel-window-from-column";

      # ─── Audio / Brightness ───
      "XF86AudioRaiseVolume".action  = a.spawn "pamixer" "-i" "5";
      "XF86AudioLowerVolume".action  = a.spawn "pamixer" "-d" "5";
      "XF86AudioMute".action         = a.spawn "pamixer" "-t";
      "XF86AudioPlay".action         = a.spawn "playerctl" "play-pause";
      "XF86AudioNext".action         = a.spawn "playerctl" "next";
      "XF86AudioPrev".action         = a.spawn "playerctl" "previous";
      "XF86MonBrightnessUp".action   = a.spawn "brightnessctl" "set" "+5%";
      "XF86MonBrightnessDown".action = a.spawn "brightnessctl" "set" "5%-";

      # ─── Lock Screen ───
      "Mod+Escape".action    = a.spawn "swaylock" "-f";
    };
  };
}
