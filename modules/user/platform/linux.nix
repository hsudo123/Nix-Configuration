{ inputs, ... }:

{
    flake.modules.homeManager.linux = { config, pkgs, ... }: let
        
    in {
        home.username = "hanyu";
	    home.homeDirectory = "/home/hanyu";
        home.stateVersion = "26.05";
        programs.home-manager.enable = true;
    };
}