{ inputs, ... }:

{
    flake.modules.nixos.nvidia = { config, pkgs, ... }: let
        
    in {
        hardware.graphics.enable = true;
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia.open = true;  # see the note above
        hardware.nvidia.modesetting.enable = true;

        hardware.nvidia.prime = {
            intelBusId = "PCI:0@0:2:0";
            nvidiaBusId = "PCI:1@0:0:0";
            # amdgpuBusId = "PCI:5@0:0:0"; # If you have an AMD iGPU
        };
    };
}