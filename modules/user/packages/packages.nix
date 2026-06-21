{ inputs, ... }:

{
    flake.modules.homeManager.packages = { pkgs, ... }: {
        home.packages = with pkgs;[
            ffmpeg
            freetube
        ];

        home.file.".config/java/java17".source = pkgs.zulu17;
	    home.file.".config/java/java21".source = pkgs.zulu21;
    };
}