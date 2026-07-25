{ inputs, self, ...}:

{
    flake.modules.nixos.hardware = { pkgs, lib, config, modulesPath, ... }: {
        imports = [
            (modulesPath + "/installer/scan/not-detected.nix")
        ];

        boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-intel" "nvidia" ];
        boot.extraModulePackages = [ ];

        fileSystems."/" = {
            device = "/dev/disk/by-uuid/bc7a4979-70af-4b4e-890d-5f1ef5fd3d9f";
            fsType = "btrfs";
        };

        fileSystems."/home" = {
            device = "/dev/disk/by-uuid/bc7a4979-70af-4b4e-890d-5f1ef5fd3d9f";
            fsType = "btrfs";
            options = [ "subvol=home" ];
        };

        fileSystems."/nix" = {
            device = "/dev/disk/by-uuid/bc7a4979-70af-4b4e-890d-5f1ef5fd3d9f";
            fsType = "btrfs";
            options = [ "subvol=nix" ];
        };

        fileSystems."/boot" = {
            device = "/dev/disk/by-uuid/9500-525B";
            fsType = "vfat";
            options = [ "fmask=0077" "dmask=0077" ];
        };

        swapDevices = [{
            device = "/dev/disk/by-uuid/ad63b6fd-53f6-4838-a0b2-8774e8ed0fd4";
        }];

        # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

    flake.nixosConfigurations."HANIX" = inputs.nixpkgs.lib.nixosSystem {
        modules = with self.modules.nixos; [
            # nix
            # darwin
            # shell
            # locale
            # hardware
            # ai
            # search
            # packages
        ];
    };

    # flake.homeConfigurations."hanyu-nixos" = inputs.home-manager.lib.homeManagerConfiguration {
    #     pkgs = import inputs.nixpkgs {
    #         system = "x86_64-linux"; # 依你的硬體平台而定
    #         config.allowUnfree = true;  # ✨ 允許閉源軟體
    #     };

    #     modules = with self.modules.homeManager; [
    #         darwin
    #         shell
    #         IDE
    #         packages
    #         agent
    #     ];
    # };
}
