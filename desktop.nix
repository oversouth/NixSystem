{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Display Manager & Desktop Environments
  services.displayManager.gdm.enable = true; # GNOME Display Manager
  services.desktopManager.plasma6.enable = true; # KDE Plasma 6 (will remove soon)
  services.desktopManager.gnome.enable = true; # GNOME (50, waiting for 51 on nixpkgs 26.05)

  programs.ssh.askPassword = lib.mkForce "/run/current-system/sw/bin/ksshaskpass"; # Use KDE sshaskpass for ssh pwd prompt (todo: replace)
  # Audio (PipeWire)
  services.pulseaudio.enable = false; # Disable PulseAudio, use PipeWire instead
  security.rtkit.enable = true; # Real-time scheduling for PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # Запрещаем WirePlumber переключать Marshall в режим "бочки" (гарнитуры)
    wireplumber.extraConfig = {
      "10-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset" = false;
        };
      };
    };
  };
