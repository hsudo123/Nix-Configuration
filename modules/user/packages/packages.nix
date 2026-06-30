{ inputs, ... }:

{
    flake.modules.homeManager.packages = { pkgs, ... }: let
        JViewer = pkgs.stdenvNoCC.mkDerivation rec {
            pname = "JHenTai";
            version = "8.0.13+312";

            src = pkgs.fetchurl {
                url = "https://github.com/jiangtian616/JHenTai/releases/download/v${version}/JHenTai-${version}.dmg";
                sha256 = "sha256-pVmhjUW+I23bHVU49m7MWqcnvHjgRQjhSv8lFPom+FY="; 
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
        home.packages = with pkgs;[
            n8n
            obsidian
            ffmpeg
            freetube
            JViewer
        ];

        home.file.".config/java/java17".source = pkgs.zulu17;
	    # home.file.".config/java/java21".source = pkgs.zulu21;
        home.file.".config/java/java21" = {
            source = pkgs.zulu21;
            recursive = true; # 這會把檔案實際 bind/copy 過去，而不是單純做 symlink
        };
    };
}