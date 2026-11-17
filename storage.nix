{ ... }:

{
  # Memory and swap
  zramSwap = {
    enable = true;
    memoryPercent = 20;
  };

  services.udisks2.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 2 * 1024; # 2 GiB
    }
  ];
}
