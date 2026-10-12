{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Display Manager & Desktop Environments
  services.displayManager.gdm.enable = true; #Gnome Display Manager
services.desktopManager.plasma6.enable = true; #KDE Plasma 6(will remove soon)
  services.desktopManager.gnome.enable = true; #Gnome(50,waiting for 51 on nixpkgs 26.05)

  programs.ssh.askPassword = lib.mkForce "/run/current-system/sw/bin/ksshaskpass"; #Use KDE sshaskpass for ssh pwd prompt(todo: replace)
  services.pulseaudio.enable = false; #Disable pulseaudio, use pipewire instead
  security.rtkit.enable = true; #Real time scheduling for pipewire(legacy)
  services.pipewire = { #Pipewire here
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
