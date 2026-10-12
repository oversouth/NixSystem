# NixConfig

NixOS configuration for the host `BBRWAX9`, split into small modules.

## Deploying

The aliases in `environment.nix` expect this repository at `~/.config/nixos`:

```sh
git clone https://github.com/oversouth/NixConfig ~/.config/nixos
sudo nixos-rebuild switch -I nixos-config=$HOME/.config/nixos/configuration.nix
```

After the first switch, `rebuild` runs the same command and `nixconf` opens
`configuration.nix` in `micro`.

## Bootstrapping a new machine

1. Install NixOS and clone this repo to `~/.config/nixos`.
2. Regenerate the hardware file for the new machine:
   `sudo nixos-generate-config --show-hardware-config > ~/.config/nixos/hardware-configuration.nix`
3. Update the machine-specific values: the games disk UUID in `storage.nix`
   and the hostname in `configuration.nix`.
4. Run the `nixos-rebuild switch` command above.
