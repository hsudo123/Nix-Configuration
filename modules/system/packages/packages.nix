{ inputs, ... }:

{
    flake.modules.generic.packages = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [ 
            # 基礎編輯與資訊工具
            vim
            fastfetch 
            
            # 系統與雜項 CLI
            age
            btop
            tree
            tmux
            wget
            zstd
            pciutils # macOS/Linux 通用的 lspci 基礎包
            
            # 網路排查
            nmap

            git
        ];
    };
    
    flake.modules.darwin.packages = { pkgs, config, ... }: let
        JViewer = pkgs.stdenvNoCC.mkDerivation rec {
            pname = "JHenTai";
            version = "8.0.14+323";

            src = pkgs.fetchurl {
                url = "https://github.com/jiangtian616/JHenTai/releases/download/v${version}/JHenTai-${version}.dmg";
                sha256 = "sha256-hqfPBveuNRQfGARnwEY0QDF/9LxDFjBhxvAuum7Q/JE="; 
            };

            nativeBuildInputs = [ pkgs.undmg ];

            unpackPhase = ''
                # 1. 建立一個絕對唯一的乾淨工作目錄
                mkdir source
                cd source

                # 2. 手動將 dmg 解壓到當前這個「唯一」的 source 目錄中
                undmg $src
            '';

            installPhase = ''
                mkdir -p $out/Applications
                cp -r JHenTai.app $out/Applications/
            '';
        };
    in {
        imports = [
            inputs.self.modules.generic.packages
        ];

        environment.systemPackages = with pkgs; [ 
            JViewer
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
                "rectangle"
                "helium-browser"
                "discord"
                "libreoffice"
                "prismlauncher"
            ];
            masApps = {
                "WireGuard" = 1451685025;
                "KDE Connect" = 1580245991;
            };
        };
    };

    flake.modules.nixos.packages = { pkgs, config, ... }: {
        imports = [
            inputs.self.modules.generic.packages
        ];

        environment.systemPackages = with pkgs; [
            kdePackages.kdeconnect-kde
        ];

        programs.firefox.enable = true;
    };
}
