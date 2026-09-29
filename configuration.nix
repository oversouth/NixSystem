{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot-hardware.nix
    ./desktop.nix
    ./software.nix
    ./virtualization.nix
    ./environment.nix
  ];

  # Storage
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/c2054c13-54eb-4770-976e-a72a074b7990";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  # Network
  networking.hostName = "BBRWAX9";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Time / Locale
  time.timeZone = "Asia/Tbilisi";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ka_GE.UTF-8";
    LC_IDENTIFICATION = "ka_GE.UTF-8";
    LC_MEASUREMENT = "ka_GE.UTF-8";
    LC_MONETARY = "ka_GE.UTF-8";
    LC_NAME = "ka_GE.UTF-8";
    LC_NUMERIC = "ka_GE.UTF-8";
    LC_PAPER = "ka_GE.UTF-8";
    LC_TELEPHONE = "ka_GE.UTF-8";
    LC_TIME = "ka_GE.UTF-8";
  };

  # User Account
  users.users.pavelzaikin = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = "pavelzaikin";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "kvm"
      "libvirtd"
      "docker"
    ];
    packages = with pkgs; [
      telegram-desktop
      fastfetch
      git
      micro
    ];
  };

  system.stateVersion = "26.05";
}
