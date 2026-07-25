{ inputs, ... }:

{
    flake.modules.nixos.nvidia = { config, pkgs, ... }: let
        
    in {
        hardware.graphics = {
            enable = true;
            enable32Bit = true; # Recommended for Steam / Proton gaming
        };

        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
            # Modesetting is required for almost all setups
            modesetting.enable = true;

            # Enables the nvidia-settings menu utility
            nvidiaSettings = true;

            # Optional: Enable power management to help battery life on Pascal cards
            powerManagement.enable = true;

            # Setup Optimus PRIME (Hybrid Graphics)
            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true; # Adds the `nvidia-offload` command
                };
            };
        };
    };
}
