{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  # /boot is a small vfat partition: keep only the most recent generations.
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nohibernate" ];
  # NOTE: openrazer is an out-of-tree kernel module. If it fails to build on a
  # brand-new kernel after an update, switch to pkgs.linuxPackages (default LTS).
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];

  # Graphics & Bluetooth
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Legacy 32-bit graphics
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Peripheral Hardware Services
  # services.ratbagd.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # hardware.openrazer.enable = true;
  # hardware.openrazer.users = [ vars.username ];

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.pantum-driver ];
  };
}
