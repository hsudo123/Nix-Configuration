{ inputs, ... }:

{
    flake.modules.darwin.shell = { pkgs, ... }: let
        lang = "zh_TW.UTF-8";
    in {
        programs.zsh.enable = true;

        environment.variables = {
            LANG = lang;
            LC_ALL = lang;
        };
    };
}