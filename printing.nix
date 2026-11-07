{ pkgs, ... }:

{
  services.printing = {
    enable = true;
    drivers = [ pkgs.pantum-driver ];
  };
}
