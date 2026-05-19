# ══════════════════════════════════════════════════════════
#  Shell & Terminal Configuration
# ══════════════════════════════════════════════════════════
{ config, pkgs, ... }:

{
  # ── Fish Shell ──────────────────────────────────────────
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Disable greeting
      set -g fish_greeting

      # Set editor
      set -gx EDITOR nvim
      set -gx VISUAL nvim
    '';

    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      ".." = "cd ..";
      "..." = "cd ../..";
      nrs = "sudo nixos-rebuild switch --flake .#nightraven";
      nrb = "sudo nixos-rebuild boot --flake .#nightraven";
      nrt = "sudo nixos-rebuild test --flake .#nightraven";
    };
  };

  # ── Starship Prompt ────────────────────────────────────
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        $username$hostname$directory$git_branch$git_status$nix_shell$cmd_duration
        $character
      '';

      character = {
        success_symbol = "[❯](bold #7aa2f7)";
        error_symbol = "[❯](bold #f7768e)";
      };

      directory = {
        style = "bold #7dcfff";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        style = "bold #bb9af7";
        symbol = " ";
      };

      git_status = {
        style = "bold #e0af68";
      };

      nix_shell = {
        symbol = "❄ ";
        style = "bold #7aa2f7";
      };

      cmd_duration = {
        style = "bold #565f89";
        min_time = 2000;
      };
    };
  };

  # ── Alacritty Terminal ─────────────────────────────────
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = { x = 12; y = 12; };
        decorations = "None";
        opacity = 0.92;
        blur = true;
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold.style = "Bold";
        italic.style = "Italic";
        size = 12.0;
      };

      # Tokyo Night color scheme
      colors = {
        primary = {
          background = "#1a1b26";
          foreground = "#c0caf5";
        };
        cursor = {
          text = "#1a1b26";
          cursor = "#c0caf5";
        };
        normal = {
          black   = "#15161e";
          red     = "#f7768e";
          green   = "#9ece6a";
          yellow  = "#e0af68";
          blue    = "#7aa2f7";
          magenta = "#bb9af7";
          cyan    = "#7dcfff";
          white   = "#a9b1d6";
        };
        bright = {
          black   = "#414868";
          red     = "#f7768e";
          green   = "#9ece6a";
          yellow  = "#e0af68";
          blue    = "#7aa2f7";
          magenta = "#bb9af7";
          cyan    = "#7dcfff";
          white   = "#c0caf5";
        };
      };
    };
  };

  # ── Direnv ─────────────────────────────────────────────
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # ── Git ────────────────────────────────────────────────
  programs.git = {
    enable = true;
    settings = {
      user.name = "Your Name";       # Ganti!
      user.email = "your@email.com"; # Ganti!
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
