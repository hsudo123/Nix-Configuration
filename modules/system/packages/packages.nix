{ inputs, ... }:

{
    flake.modules.darwin.packages = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [ 
            vim
            fastfetch 
            
            # misc
            age
            btop
            tree
            tmux
            wget
            zstd
            pciutils # lspci
            usbutils # lsusb

            # networking 
            nmap
        ];

        homebrew = {
            enable = true;
            onActivation = {
                cleanup = "zap";
                autoUpdate = true;
                # Keep activation mostly automatic, but avoid MAS update/auth failures on
                # every switch. Keep masApps as inventory, but install them interactively.
                upgrade = true;
                # extraEnv.HOMEBREW_BUNDLE_MAS_SKIP = ib.concatStringsSep " " (map toString (builtins.attrValues config.homebrew.masApps));
            };
            global.autoUpdate = true;

            brews = [
                # "ansible"
            ];
            taps = [
                # Keep third-party cask taps pinned so brew bundle cleanup does not try to untap them.
                # "FelixKratz/formulae" #sketchybar
            ];
            casks = [
                "mos"
                "stats"
                "vivaldi"
                "discord"
                "rectangle"
                "prismlauncher"
                "microsoft-office"
            ];
            masApps = {
                "WireGuard" = 1451685025;
                "KDE Connect" = 1580245991;
            };
        };
    };
}