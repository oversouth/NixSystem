{ config, pkgs, ... }:

{
  # Games disk (machine-specific UUID)
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/c2054c13-54eb-4770-976e-a72a074b7990";
    fsType = "ext4";
    options = [ "defaults" "nofail" ];
  };

  # Memory and swap
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
