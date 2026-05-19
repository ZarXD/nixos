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
      {
        matches = [{ app-id = "^org\\.gnome\\."; }];
      }
    ];

    # ══════════════════════════════════════════════════════
    #  Keybindings
    #
    #  Format: "Key".action.<action-name> = <args>;
    #  - Tanpa args: = {};  atau = [];
    #  - Satu arg:   = "value";  atau = 1;
    #  - Multi args:  = ["arg1" "arg2"];
    # ══════════════════════════════════════════════════════
    binds = {
      # ─── Essentials ───
      "Mod+Return".action.spawn = "alacritty";
      "Mod+D".action.spawn = [ "sh" "-c" "qs -c noctalia-shell ipc call launcher toggle" ];
      "Mod+Shift+Q".action.close-window = {};
      "Mod+Shift+E".action.quit = {};
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};

      # ─── Screenshots ───
      "Print".action.screenshot = {};
      "Mod+Print".action.screenshot-screen = {};
      "Mod+Shift+Print".action.screenshot-window = {};

      # ─── Focus ───
      "Mod+H".action.focus-column-left = {};
      "Mod+L".action.focus-column-right = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};

      # ─── Move Windows ───
      "Mod+Shift+H".action.move-column-left = {};
      "Mod+Shift+L".action.move-column-right = {};
      "Mod+Shift+J".action.move-window-down = {};
      "Mod+Shift+K".action.move-window-up = {};
      "Mod+Shift+Left".action.move-column-left = {};
      "Mod+Shift+Right".action.move-column-right = {};
      "Mod+Shift+Down".action.move-window-down = {};
      "Mod+Shift+Up".action.move-window-up = {};

      # ─── Workspaces ───
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+Shift+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Shift+Page_Up".action.move-column-to-workspace-up = {};

      # ─── Column Width ───
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      # ─── Consume / Expel ───
      "Mod+BracketLeft".action.consume-window-into-column = {};
      "Mod+BracketRight".action.expel-window-from-column = {};

      # ─── Audio / Brightness ───
      "XF86AudioRaiseVolume".action.spawn = ["pamixer" "-i" "5"];
      "XF86AudioLowerVolume".action.spawn = ["pamixer" "-d" "5"];
      "XF86AudioMute".action.spawn = ["pamixer" "-t"];
      "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
      "XF86AudioNext".action.spawn = ["playerctl" "next"];
      "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
      "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "+5%"];
      "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];

      # ─── Lock Screen ───
      "Mod+Escape".action.spawn = ["swaylock" "-f"];
    };
  };
}
