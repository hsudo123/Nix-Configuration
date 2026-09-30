{ inputs, ... }:

{
    flake.modules.homeManager.packages = { pkgs, ... }: let
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

        eqMac = pkgs.stdenvNoCC.mkDerivation rec {
            pname = "eqMac";
            version = "1.9.1";

            src = pkgs.fetchurl {
                url = "https://github.com/bitgapp/eqMac/releases/download/v${version}/eqMac.dmg";
                sha256 = "sha256-ZV/rZXjN1c0Px6K5wJVbvdt71rsjsp6n+YKuNbi6XiY="; 
            };

            nativeBuildInputs = [  ];

            unpackPhase = ''
                MOUNT_POINT=$(mktemp -d)
                /usr/bin/hdiutil attach "$src" -mountpoint "$MOUNT_POINT" -nobrowse -quiet

                mkdir -p source
                cp -R "$MOUNT_POINT"/*.app source/

                /usr/bin/hdiutil detach "$MOUNT_POINT" -quiet
                rm -rf "$MOUNT_POINT"

                cd source
            '';

            installPhase = ''
                mkdir -p $out/Applications
                cp -R *.app $out/Applications/
            '';
        };
    in {
        home.packages = with pkgs;[
            nil
            rar
            ffmpeg
            obsidian
            localsend
            android-file-transfer
            yt-dlp
            freetube
            proton-pass
            proton-authenticator
        ]
        ++ pkgs.lib.optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") [
            # discord
            libreoffice
            prismlauncher
        ]
        ++ pkgs.lib.optionals (pkgs.stdenv.hostPlatform.system == "aarch64-darwin") [
            eqMac
            JViewer

            mos
            stats
            rectangle
            tailscale
            libreoffice-bin
        ];

        home.file.".config/java/java17".source = pkgs.zulu17;
	    # home.file.".config/java/java21".source = pkgs.zulu21;
        home.file.".config/java/java21" = {
            source = pkgs.zulu21;
            recursive = true;
        };
    };
}