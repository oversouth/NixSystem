{ pkgs, ... }:

let
  # Launcher for NekoBox AppImage
  vpn = pkgs.writeShellScriptBin "vpn" ''
    root="$HOME/.cache/appimage-run"
    bin="$(${pkgs.findutils}/bin/find "$root" -maxdepth 2 -name nekobox -type f -printf '%T@ %p\n' 2>/dev/null \
      | ${pkgs.coreutils}/bin/sort -nr \
      | ${pkgs.coreutils}/bin/head -n1 \
      | ${pkgs.coreutils}/bin/cut -d' ' -f2-)"
    if [ -z "$bin" ]; then
      echo "vpn: NekoBox not found under $root. Run the AppImage once with appimage-run first." >&2
      exit 1
    fi
    dir="$(${pkgs.coreutils}/bin/dirname "$bin")"
    export QT_QPA_PLATFORM=xcb
    export QT_QPA_PLATFORM_PLUGIN_PATH="$dir/usr/plugins/platforms"
    unset XDG_DATA_DIRS
    exec "$bin" "$@"
  '';
in
{
  # Session variables
  environment.sessionVariables = {
    TERMINAL = "ghostty";
  };

  # System packages
  environment.systemPackages = [ vpn ];

  # Shell aliases
  environment.shellAliases = {
    # System rebuild alias
    rebuild = "sudo nixos-rebuild switch -I nixos-config=$HOME/.config/nixos/configuration.nix";

    # Shortcuts
    sysinfo = "fastfetch";
    cls = "clear";
    nixconf = "micro ~/.config/nixos/configuration.nix";
    pylearning = "cd $HOME/Projects/pylearning && source .venv/bin/activate";
  };
}
