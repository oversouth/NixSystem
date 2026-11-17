{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Text login prompt which starts Hyprland after authentication.
  # Hyprlock is the in-session screen locker, not a login manager.
  services.greetd = {
    enable = true;
    settings.default_session = {
      # Persist the last successfully authenticated username so the greeter
      # only prompts for the password after the first login.
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
      user = "greeter";
    };
  };
  # Unlock GNOME Keyring during greetd login so Zed can persist its session.
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.hyprlock = { };

  # Wayland compositor
  programs.hyprland.enable = true;
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
