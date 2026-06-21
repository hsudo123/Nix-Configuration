{ inputs, ... }:

{
    flake.modules.darwin.shell = { pkgs, ... }: {
        programs.zsh.enable = true;
    };
}