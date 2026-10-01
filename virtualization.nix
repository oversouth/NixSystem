{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  programs.virt-manager.enable = true;

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  virtualisation.virtualbox.host.enable = true;
}
