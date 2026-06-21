{ inputs, ... }:

{
    flake.modules.darwin.nix = { pkgs, ... }: {
        # nixpkgs.hostPlatform = pkgs.stdenv.hostPlatform.system;
        nixpkgs.config.allowUnfree = true;

        nix.settings.experimental-features = "nix-command flakes";

        nix.gc = {
            automatic = true;
            interval = { Hour = 6; Minute = 0; Weekday = 7; }; # 每週日凌晨6點
            options = "--delete-older-than 7d";
        };
    };
}