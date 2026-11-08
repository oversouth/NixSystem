{ ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  programs.virt-manager.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.vmware.host.enable = true;
  
}
