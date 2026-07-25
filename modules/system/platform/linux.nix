{ inputs, ... }:

{
    flake.modules.nixos.nixos = { config, pkgs, ... }: let
        
    in {
        services.xserver.enable = true;
        services.displayManager.sddm = {
            enable = true;
            autoNumlock = true;
            wayland.enable = true;
        };
        services.desktopManager.plasma6.enable = true;

        services.printing.enable = true;
    };
}