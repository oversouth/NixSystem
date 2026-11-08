# NixConfig

NixOS configuration for the host `BBRWAX9`, split into small modules.

## Modules

- `configuration.nix`: system entrypoint and host level settings
- `users.nix`: user accounts
- `boot-hardware.nix`, `desktop.nix`, `software.nix`, `virtualization.nix`,
  `storage.nix`, and `environment.nix`: focused system modules
- `hardware-configuration.nix`: generated machine hardware settings
- `home-manager.nix`: standalone Home Manager configuration for selected user settings
- `dotfiles/`: versioned copies of those settings, excluding application state and credentials

## Deploying

The aliases in `environment.nix` expect this repository at `~/.config/nixos`:

```sh
git clone https://github.com/oversouth/NixConfig ~/.config/nixos
sudo nixos-rebuild switch -I nixos-config=$HOME/.config/nixos/configuration.nix
```

After the first switch, `rebuild` runs the same command and `nixconf` opens
`configuration.nix` in `micro`.

## Home Manager

The listed files are linked into their usual `~/.config` locations, so apps
continue to read their normal paths while Home Manager supplies the contents.
Activate Home Manager the first time with:

```sh
home-manager switch -b backup -f ~/.config/nixos/home-manager.nix
```

This preserves any existing files that conflict with Home Manager's links. The
first switch installs the `hm-rebuild` and `hmconf` shell aliases. Open a
new shell, then use `hm-rebuild` after changing a config in `dotfiles/` or
`home-manager.nix`. Restart the affected app to reload its settings. `hmconf`
opens the Home Manager entry point.

It manages selected application settings under `~/.config` from `dotfiles/`.
Browser profiles, tokens, databases, caches, session state, and KDE/Plasma
settings are excluded.

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
