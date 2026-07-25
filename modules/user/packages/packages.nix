{ inputs, ... }:

{
    flake.modules.homeManager.packages = { pkgs, ... }: {
        home.packages = with pkgs;[
            # n8n
            obsidian
            ffmpeg
            freetube
        ]
        ++ pkgs.lib.optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") [
            discord
            libreoffice
            prismlauncher
        ];

        home.file.".config/java/java17".source = pkgs.zulu17;
	    # home.file.".config/java/java21".source = pkgs.zulu21;
        home.file.".config/java/java21" = {
            source = pkgs.zulu21;
            recursive = true; # 這會把檔案實際 bind/copy 過去，而不是單純做 symlink
        };
    };
}