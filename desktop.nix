{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.ssh.askPassword = lib.mkForce "/run/current-system/sw/bin/ksshaskpass";

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
