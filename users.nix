{ pkgs, ... }:

let
  vars = import ./vars.nix;
in
{
  # Primary user account.
  users.users.${vars.username} = {
    isNormalUser = true;
    shell = pkgs.bash;
    description = vars.username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "kvm"
      "docker"
      "dialout"
    ];
    packages = with pkgs; [
      telegram-desktop
      fastfetch
      micro
    ];
  };

  # Additional user account.
  users.users.username = {
    isNormalUser = true;
    description = "slop";
    extraGroups = [ "wheel" "networkmanager" "docker" "kvm" ];
  };
}
