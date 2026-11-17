#!/usr/bin/env bash
set -e

# Проверка прав root
if [ "$EUID" -ne 0 ]; then
  echo "[-] Перезапуск скрипта с sudo..."
  exec sudo "$0" "$@"
fi

USERNAME="${SUDO_USER:-$(whoami)}"
USER_HOME=$(eval echo "~$USERNAME")

echo "[+] Начинаем развертывание Fedora с KDE Plasma для пользователя: $USERNAME"

# 1. Обновление системы и подключение RPM Fusion (Free & Nonfree)
echo "[+] Настройка репозиториев и обновление системы..."
dnf upgrade -y
dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf config-manager setopt fedora-cisco-openh264.enabled=1 || true

# 2. Установка KDE Plasma и SDDM
echo "[+] Установка KDE Plasma Workspaces и SDDM..."
dnf group install -y kde-desktop-environment
systemctl enable sddm
systemctl set-default graphical.target

# 3. Установка основного софта и утилит
echo "[+] Установка пакетов (терминалы, разработка, утилиты)..."
dnf install -y \
    ghostty yazi micro fastfetch git ripgrep unzip wget curl \
    python3 python3-pip gcc cmake gparted wine android-tools \
    jetbrains-mono-fonts-all nodejs discord \
    NetworkManager-tui util-linux-user

# 4. Установка Steam и Tailscale
echo "[+] Установка Steam и Tailscale..."
dnf install -y steam
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf install -y tailscale
systemctl enable --now tailscaled

# 5. Настройка официального Docker CE
echo "[+] Установка и настройка Docker..."
dnf remove -y podman-docker || true
dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl enable --now docker
usermod -aG docker "$USERNAME"

# 6. Системные фиксы под железо и аудио
echo "[+] Применение системных патчей (Intel Backlight & WirePlumber)..."

# Фикс яркости экрана Intel через udev
mkdir -p /etc/udev/rules.d
cat << 'EOF' > /etc/udev/rules.d/99-backlight.rules
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", ATTR{brightness}="96000"
EOF

# Запрет WirePlumber переключать Bluetooth-наушники в режим гарнитуры («бочки»)
mkdir -p /etc/wireplumber/wireplumber.conf.d
cat << 'EOF' > /etc/wireplumber/wireplumber.conf.d/10-bluetooth-policy.conf
wireplumber.settings = {
  "bluetooth.autoswitch-to-headset" = false
}
EOF

# 7. Клонирование реального репозитория NixSystem и перенос дотфайлов (минуя hypr/noctalia)
echo "[+] Развертывание дотфайлов из репозитория oversouth/NixSystem..."
REPO_DIR="$USER_HOME/NixSystem"

if [ ! -d "$REPO_DIR" ]; then
  su - "$USERNAME" -c "git clone https://github.com/oversouth/NixSystem $REPO_DIR"
fi

if [ -d "$REPO_DIR/dotfiles" ]; then
  su - "$USERNAME" -c "
    mkdir -p $USER_HOME/.config
    for item in $REPO_DIR/dotfiles/*; do
      name=\$(basename \"\$item\")
      if [ \"\$name\" != \"hypr\" ] && [ \"\$name\" != \"noctalia\" ]; then
        ln -sfn \"\$item\" \"$USER_HOME/.config/\$name\"
        echo \"  -> Прилинкован \$name\"
      fi
    done
  "
fi

# 8. Добавление пользователя в нужные группы
echo "[+] Настройка групп пользователя ($USERNAME)..."
usermod -aG wheel,dialout,adbusers "$USERNAME"

echo "======================================================="
echo "[✔] Всё готово! Чистая Fedora + KDE Plasma настроены."
echo "[✔] Перезагружайся командой: reboot"
echo "======================================================="
