# NixConfig

NixOS configuration for the host `BBRWAX9`, split into small modules.

## Modules

- `configuration.nix`: system entrypoint and host level settings
- `users.nix`: user accounts
- `home.nix`: Home Manager settings for `pavelzaikin`, loaded by the NixOS module
- `boot-hardware.nix`, `desktop.nix`, `software.nix`, `virtualization.nix`,
  `storage.nix`, and `environment.nix`: focused system modules
- `hardware-configuration.nix`: generated machine hardware settings

## Deploying

Home Manager is integrated as a NixOS module and shares the system package set.
The root user's channel must contain the matching Home Manager release; this
system runs NixOS 26.05:

```sh
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
sudo nix-channel --update
```

Apply both the system and Home Manager configuration with:

```sh
sudo nixos-rebuild switch -I nixos-config=/home/pavelzaikin/.config/nixos/configuration.nix
```

Every regular file under `dotfiles/` is linked to the matching path under
`~/.config` by `home.nix`. Keep those files as the canonical copies and add
new settings there; Home Manager replaces matching files at activation, so
existing settings were reconciled into the repository first. App state and
credentials outside `dotfiles/` are not managed.

The aliases in `environment.nix` expect this repository at `~/.config/nixos`:

```sh
git clone https://github.com/oversouth/NixConfig ~/.config/nixos
sudo nixos-rebuild switch -I nixos-config=$HOME/.config/nixos/configuration.nix
```

After the first switch, `rebuild` runs the same command and `nixconf` opens
`configuration.nix` in `micro`.

Hyprland 0.55 uses `hyprland.lua`, so the config in `dotfiles/hypr/` is Lua;
the old `hyprland.conf` format is ignored by this installed version. Login uses
greetd with tuigreet, and Hyprlock is the in-session locker on Super+L.

## Bootstrapping a new machine

1. Install NixOS and clone this repo to `~/.config/nixos`.
2. Regenerate the hardware file for the new machine:
   `sudo nixos-generate-config --show-hardware-config > ~/.config/nixos/hardware-configuration.nix`
3. Update the machine-specific values: the games disk UUID in `storage.nix`
   and the hostname in `configuration.nix`.
4. Run the `nixos-rebuild switch` command above.
