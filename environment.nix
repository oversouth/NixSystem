{ config, pkgs, ... }:

{
  # Переменные окружения
  environment.sessionVariables = {
    TERMINAL = "konsole";
  };

  # Алиасы для шелла
  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch";
    sysinfo = "fastfetch";
    cls = "clear";
    nixconf = "micro ~/.config/nixos/configuration.nix";

    pylearning = "cd Projects/pylearning && source .venv/bin/activate";

    vpn = "QT_QPA_PLATFORM=xcb QT_QPA_PLATFORM_PLUGIN_PATH=\"$HOME/.cache/appimage-run/bec95e7fafe7f7f10923977c9f7511c878aa25a7eecc51c53ae85d8f35e24b35/usr/plugins/platforms\" env -u XDG_DATA_DIRS \"$HOME/.cache/appimage-run/bec95e7fafe7f7f10923977c9f7511c878aa25a7eecc51c53ae85d8f35e24b35/nekobox\"";
  };

  # Оптимизация памяти и свопа
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 4 * 1024;
    }
  ];
}
