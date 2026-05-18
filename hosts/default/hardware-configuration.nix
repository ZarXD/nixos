# ═══════════════════════════════════════════════════════════
#  PLACEHOLDER - Hardware Configuration
#  ───────────────────────────────────────────────────────────
#  File ini harus di-generate di mesin NixOS kamu dengan:
#
#    sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
#
#  Lalu replace isi file ini dengan output-nya.
# ═══════════════════════════════════════════════════════════
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # ── Contoh: Boot/Kernel ──
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ]; # Ganti ke kvm-amd kalau CPU AMD
  boot.extraModulePackages = [ ];

  # ── Contoh: Filesystem ──
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ ];

  # ── Hardware ──
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
