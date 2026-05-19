# ══════════════════════════════════════════════════════════
#  NVIDIA (RTX 3050 + Intel UHD Hybrid)
#
#  JANGAN import file ini kalau di VM!
#  Hanya untuk hardware asli dengan NVIDIA GPU.
# ══════════════════════════════════════════════════════════
{ config, pkgs, ... }:

{
  hardware.nvidia = {
    # Pakai driver production (stable)
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # Modesetting wajib untuk Wayland
    modesetting.enable = true;

    # Power management — hemat baterai
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # Open source kernel module (RTX 3050 supported)
    open = true;

    # NVIDIASettings GUI (opsional)
    nvidiaSettings = true;

    # PRIME — Hybrid GPU (Intel + NVIDIA)
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;  # Bisa pakai `nvidia-offload <app>`
      };

      # Bus ID — cek pakai `lspci | grep -E "VGA|3D"`
      # Format: PCI:x:y:z
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
