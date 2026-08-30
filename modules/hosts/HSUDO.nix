{ inputs, self, ...}:

{
    flake.darwinConfigurations."HSUDO" = inputs.nix-darwin.lib.darwinSystem {
        modules = with self.modules.darwin; [
            nix
            platform
            shell
            locale
            ai
            search
            packages
        ];
    };

    flake.homeConfigurations = {
        "hanyu@HSUDO" = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
                system = "aarch64-darwin";
                config.allowUnfree = true;
            };

            modules = with self.modules.homeManager; [
                darwin
                shell
                IDE
                packages
                agent
            ];
        };

        "hanyu@HANIX" = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
                system = "x86_64-linux";
                config.allowUnfree = true;
            };

            modules = with self.modules.homeManager; [
                linux
                shell
                IDE
                packages
            ];
        };
    };
}