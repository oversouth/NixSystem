{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  environment.systemPackages = with pkgs; [
    # Utilities
    gparted wine cava firefox swaylock nerd-fonts.jetbrains-mono
    # Wayland / Niri
    wl-clipboard waybar grim slurp swaybg rofi
    # Android & Dev
    android-studio heimdall samloader-rs android-tools
    python3 cmake gcc git vscode godot nodejs tsx
    # Networking & Misc (obs-studio comes from programs.obs-studio below)
    networkmanagerapplet yandex-music tree
  ];

  programs.kdeconnect.enable = true;
  programs.obs-studio.enable = true;
  programs.k3b.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # nix-ld (run unpatched binaries)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc zlib libpng qt5.qtbase qt5.qtsvg qt5.qtx11extras
    libx11 libxext libxcursor libxrandr libxi libxkbcommon
    libGL vulkan-loader glfw libpulseaudio openal udev fontconfig freetype glib dbus
  ];
}
