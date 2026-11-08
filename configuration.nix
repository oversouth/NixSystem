{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot-hardware.nix
    ./desktop.nix
    ./printing.nix
    ./software.nix
    ./virtualization.nix
    ./storage.nix
    ./environment.nix
    ./users.nix
  ];

  # Network
  networking.hostName = "BBRWAX9";
  networking.networkmanager.enable = true;

  # OpenSSH Service
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = true;
    };
  };

  # Firewall rules
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 5900 ]; # SSH and VNC
  };

  # Intel Backlight Fix (Disable systemd backlight save/restore & set default via udev)
  systemd.services."systemd-backlight@backlight:intel_backlight".enable = false;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", ATTR{brightness}="96000"
  '';
  services.udev.packages = [ pkgs.opentabletdriver ];

  # Kernel modules
  boot.kernelModules = [ "vmmon" "vmnet" ];

  # Nix Package Manager Settings & Maintenance
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;

  # Time / Locale
  time.timeZone = "Asia/Tbilisi";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  system.stateVersion = "26.05";
}
