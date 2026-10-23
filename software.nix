{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true; # Proprietary packages
    android_sdk.accept_license = true; #Android proprietary packages
  };

  environment.systemPackages = with pkgs; [
    # Utilities
    gparted wine firefox nerd-fonts.jetbrains-mono vis yazi ghostty 
    # Wayland
    wl-clipboard rofi
    # Development
    android-studio android-tools
    python3 cmake gcc git vscode godot tsx
    pkgs.git pkgs.gcc pkgs.ripgrep pkgs.unzip
    # Networking & Misc (obs-studio comes from programs.obs-studio below)
    networkmanagerapplet yandex-music ayugram-desktop v2rayn osu-lazer-bin
  ];
  programs.kdeconnect.enable = true;
  programs.obs-studio.enable = true;
  # programs.k3b.enable = true; # Not needed for now

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
