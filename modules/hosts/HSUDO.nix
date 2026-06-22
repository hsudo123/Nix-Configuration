{ inputs, self, ...}:

{
    flake.darwinConfigurations."HSUDO" = inputs.nix-darwin.lib.darwinSystem {
        modules = with self.modules.darwin; [
            nix
            darwin
            shell
            locale
            ai
            search
            packages
        ];
    };

    flake.homeConfigurations."hanyu" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
            system = "aarch64-darwin"; # 依你的硬體平台而定
            config.allowUnfree = true;  # ✨ 允許閉源軟體
        };

        modules = with self.modules.homeManager; [
            darwin
            shell
            IDE
            packages
        ];
    };
}