{ ... }:

{
  # Полностью выключаем systemd-boot
  boot.loader.systemd-boot.enable = false;

  # Включаем GRUB для UEFI
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };

  # Обязательно для UEFI, чтобы обновлять записи в NVRAM
  boot.loader.efi.canTouchEfiVariables = true;
}
