{ config, pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    ./boot-hardware.nix
    ./desktop.nix
    ./software.nix
    ./virtualization.nix
    ./storage.nix
    ./environment.nix
  ];

  # Network
  networking.hostName = "BBRWAX9";
  networking.networkmanager.enable = true;

  # The firewall is on by default. Open ports explicitly where needed.
  # Waydroid's bridge needs DNS and DHCP to reach the host.
  networking.firewall.interfaces.waydroid0 = {
    allowedUDPPorts = [ 53 67 ];
    allowedTCPPorts = [ 53 ];
  };

  # Nix maintenance
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

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
  users.users.${vars.username} = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = vars.username;
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
      micro
    ];
  };

  system.stateVersion = "26.05";
}
