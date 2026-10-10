{ inputs, ... }:

{
    flake.modules.generic.nix = { pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;

        nix.settings = {
            experimental-features = "nix-command flakes";
            trusted-users = [ "root" "hanyu" ];
            auto-optimise-store = true;
        };
    };

    flake.modules.darwin.nix = { pkgs, ... }: {
        imports = [
            inputs.self.modules.generic.nix
        ];

        nix.gc = {
            automatic = true;
            interval = { Hour = 6; Minute = 0; Weekday = 7; }; # 每週日凌晨6點
            options = "--delete-older-than 7d";
        };
    };

    flake.modules.nixos.nix = { pkgs, ... }: {
        imports = [
            inputs.self.modules.generic.nix
        ];

        nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };
}
