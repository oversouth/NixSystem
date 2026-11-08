{ ... }:

let
  configFiles = [
    "caelestia/shell.json"
    "cava/config"
    "fastfetch/config.jsonc"
    "chrome-flags.conf"
    "code-flags.conf"
    "fontconfig/fonts.conf"
    "ghostty/config"
    "ghostty/config.ghostty"
    "ghostty/themes/BreezeDark"
    "git/ignore"
    "gtk-3.0/colors.css"
    "gtk-3.0/gtk.css"
    "gtk-3.0/settings.ini"
    "gtk-4.0/colors.css"
    "gtk-4.0/gtk.css"
    "gtk-4.0/settings.ini"
    "gtkrc"
    "gtkrc-2.0"
    "hypr/hyprland.lua"
    "hypr/hyprlock.conf"
    "micro/bindings.json"
    "micro/settings.json"
    "mimeapps.list"
    "mpv/mpv.conf"
    "nvim/init.lua"
    "nvim/lazy-lock.json"
    "nvim/lazyvim.json"
    "nvim/stylua.toml"
    "noctalia/colors.json"
    "noctalia/plugins.json"
    "noctalia/settings.json"
    "nixpkgs/config.nix"
    "obs-studio/global.ini"
    "obs-studio/user.ini"
    "qBittorrent/qBittorrent.conf"
    "rygel.conf"
    "user-dirs.dirs"
    "user-dirs.locale"
    "xsettingsd/xsettingsd.conf"
    "xenia_edge.conf"
    "QtProject.conf"
    "Trolltech.conf"
    "xdg-terminals.list"
    "xdg-desktop-portal/hyprland-portals.conf"
    "zed/settings.json"
    "zshrc.d/auto-Hypr.sh"
    "zshrc.d/dots-hyprland.zsh"
    "zshrc.d/shortcuts.zsh"
  ];
in
{
  home.username = "pavelzaikin";
  home.homeDirectory = "/home/pavelzaikin";
  home.stateVersion = "25.11";
  home.shellAliases = {
    hm-rebuild = "home-manager switch -b backup -f $HOME/.config/nixos/home-manager.nix";
    hmconf = "micro ~/.config/nixos/home-manager.nix";
  };

  xdg.enable = true;
  xdg.configFile = builtins.listToAttrs (map (path: {
    name = path;
    value.source = ./dotfiles + "/${path}";
  }) configFiles);

  programs.home-manager.enable = true;
}
