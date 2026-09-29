{ config, pkgs, ... }:

{
  # Bootloader & Kernel
  boot.loader.systemd-boot.enable = true;
  boot.kernelParams = [ "nohibernate" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "ntfs" ];

  # Graphics & Bluetooth
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Peripheral Hardware Services
  services.ratbagd.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "pavelzaikin" ];

  # Printing
  services.printing = {
    enable = true;
    drivers = [ pkgs.pantum-driver ];
  };
}
