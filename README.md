# 🌙 Nightraven — NixOS + Niri + Noctalia Shell

NixOS configuration with **Niri** (scrollable tiling Wayland compositor) and **Noctalia Shell** (Wayland-native desktop shell), managed via **flake-parts**.

## Stack

| Component | Tool |
|---|---|
| **Flake Framework** | `flake-parts` |
| **Compositor** | Niri (scrollable tiling Wayland) |
| **Desktop Shell** | Noctalia Shell (bar, dock, notifications) |
| **Display Manager** | greetd + tuigreet |
| **Audio** | PipeWire |
| **Terminal** | Alacritty (Tokyo Night theme) |
| **Shell** | Fish + Starship prompt |
| **Launcher** | Fuzzel |
| **Color Scheme** | Tokyo Night |
| **GTK Theme** | Adwaita-dark + Papirus icons + Bibata cursor |

## Struktur Direktori

```
.
├── flake.nix                          # Entry point (flake-parts)
├── flake-modules/
│   └── nixos.nix                      # NixOS configurations module
├── hosts/
│   └── default/
│       ├── configuration.nix          # System config (boot, audio, fonts, dll)
│       └── hardware-configuration.nix # Hardware config (HARUS di-replace!)
└── home/
    ├── default.nix                    # Home Manager entry point
    ├── niri.nix                       # Niri compositor config (keybindings, layout)
    ├── noctalia.nix                   # Noctalia Shell config
    ├── shell.nix                      # Fish + Starship + Alacritty + Git
    ├── packages.nix                   # User packages
    └── gtk.nix                        # GTK/Qt theming (dark mode)
```

---

## Instalasi

### Phase 1 — Persiapan

1. **Download ISO NixOS** dari https://nixos.org/download
   - Bisa pakai **Minimal** atau **Graphical** ISO (keduanya bisa)
   - Flash ke USB pakai [Ventoy](https://ventoy.net), [Rufus](https://rufus.ie), atau `dd`

2. **Boot dari USB** — masuk BIOS → set boot priority ke USB

### Phase 2 — Partisi & Format Disk

> **⚠️ Ini akan HAPUS SEMUA DATA di disk tersebut! Pastikan sudah backup.**

**Opsi A — Graphical ISO (Calamares):**
Ikuti wizard GUI → partisi, user, timezone → selesai → lanjut ke Phase 4.

**Opsi B — Manual via terminal:**

```bash
# Cek disk
lsblk

# Partisi (contoh: /dev/sda — untuk NVMe ganti ke /dev/nvme0n1)
sudo parted /dev/sda -- mklabel gpt
sudo parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/sda -- set 1 esp on
sudo parted /dev/sda -- mkpart primary ext4 512MiB 100%

# Format
sudo mkfs.fat -F 32 -n boot /dev/sda1
sudo mkfs.ext4 -L nixos /dev/sda2

# Mount
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
```

### Phase 3 — Install NixOS Dasar

> **Kalau pakai Calamares (Graphical ISO), skip ke Phase 4.**

```bash
# Generate hardware config
sudo nixos-generate-config --root /mnt

# Enable flakes di config default
sudo nano /mnt/etc/nixos/configuration.nix
```

Tambahkan di dalam `{ ... }`:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
environment.systemPackages = [ pkgs.git ];
```

```bash
# Install & reboot
sudo nixos-install
sudo reboot
```

### Phase 4 — Pasang Konfigurasi Nightraven

```bash
# Login sebagai root, lalu buat user (kalau belum ada via Calamares)
useradd -m -G wheel -s /bin/bash user  # ganti "user"
passwd user

# Login sebagai user
su - user

# Clone konfigurasi
git clone <repo-url> ~/nixos
cd ~/nixos
```

**Copy hardware-configuration.nix:**
```bash
cp /etc/nixos/hardware-configuration.nix ~/nixos/hosts/default/hardware-configuration.nix
```

**Sesuaikan username** — ganti semua `"user"` di 3 file:

| File | Yang diganti |
|---|---|
| `flake-modules/nixos.nix` | `users.user = import ../home;` |
| `hosts/default/configuration.nix` | `users.users.user` |
| `home/default.nix` | `username` dan `homeDirectory` |

**Sesuaikan Git identity** di `home/shell.nix`:
```nix
programs.git = {
  userName = "Nama Kamu";
  userEmail = "email@kamu.com";
};
```

**Build & Switch! 🚀**
```bash
sudo nixos-rebuild switch --flake .#nightraven
sudo reboot
```

### Phase 5 — Post-Install

```bash
# Taruh wallpaper
mkdir -p ~/wallpapers
cp /path/to/wallpaper.jpg ~/wallpapers/wallpaper.jpg
```

---

## Keybindings

| Shortcut | Action |
|---|---|
| `Mod+Return` | Terminal (Alacritty) |
| `Mod+D` | Launcher (Fuzzel) |
| `Mod+Shift+Q` | Close window |
| `Mod+H/J/K/L` | Focus left/down/up/right |
| `Mod+Shift+H/J/K/L` | Move window |
| `Mod+1-9` | Switch workspace |
| `Mod+Shift+1-9` | Move window to workspace |
| `Mod+F` | Maximize column |
| `Mod+Shift+F` | Fullscreen |
| `Mod+R` | Cycle preset column widths |
| `Mod+Minus/Equal` | Shrink/grow column width |
| `Mod+[` / `Mod+]` | Consume/expel window |
| `Mod+Escape` | Lock screen (swaylock) |
| `Mod+Shift+E` | Quit Niri |
| `Print` | Screenshot |
| `XF86Audio*` | Volume / media controls |
| `XF86MonBrightness*` | Brightness controls |

## Noctalia Shell

Noctalia di-launch otomatis oleh Niri via `spawn-at-startup`. Untuk customize:
- **GUI**: Klik kanan pada bar → Settings
- **Declarative**: Edit `home/noctalia.nix` bagian `settings`

> **💡 Tip:** Setelah customize via GUI, kamu bisa export settings dan masukkan ke Nix config untuk reproducibility.

## Update Config

```bash
cd ~/nixos
# Edit file nix...
nrs   # alias: sudo nixos-rebuild switch --flake .#nightraven
nrb   # alias: sudo nixos-rebuild boot --flake .#nightraven
nrt   # alias: sudo nixos-rebuild test --flake .#nightraven
```

---

## Troubleshooting

**Build error: hardware-configuration.nix not found**
```bash
sudo nixos-generate-config
cp /etc/nixos/hardware-configuration.nix ~/nixos/hosts/default/
```

**Noctalia Shell tidak muncul**
```bash
which noctalia-qs
noctalia-qs -c noctalia-shell  # manual launch untuk debug
```

**Niri tidak start / blank screen**
```bash
journalctl --user -u niri -b
lspci | grep VGA
```
