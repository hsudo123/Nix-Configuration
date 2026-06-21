{ inputs, ... }:

{
    flake.modules.darwin.locale = { pkgs, ... }: {
        fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
        ];

        time.timeZone = "Asia/Taipei";
    };
}