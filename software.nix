{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true; # Proprietary packages
    android_sdk.accept_license = true; # Android proprietary packages
  };

  # Включаем службу Flatpak
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    # Utilities
    gparted wine firefox nerd-fonts.jetbrains-mono vis yazi ghostty grim slurp tailscale
    # Wayland
    wl-clipboard hyprlock
    # Development
    android-tools
    python3 cmake gcc git tsx
    ripgrep unzip zed-editor
    codex
    # Networking & Misc
    networkmanagerapplet yandex-music ayugram-desktop v2rayn noctalia-shell nodejs_26 discord
  ];

  programs.obs-studio.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.tailscale.enable = true;
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [ pkgs.icu ];
    };
  };

  # nix-ld (run unpatched binaries)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc zlib libpng qt5.qtbase qt5.qtsvg qt5.qtx11extras
    libx11 libxext libxcursor libxrandr libxi libxkbcommon
    libGL vulkan-loader glfw libpulseaudio openal udev fontconfig freetype glib dbus
  ];
}
