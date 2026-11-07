{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Display manager and Wayland compositor
  services.displayManager.sddm.enable = true;
  programs.hyprland.enable = true;
  programs.ssh.askPassword = lib.mkForce "/run/current-system/sw/bin/ksshaskpass";
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
}
