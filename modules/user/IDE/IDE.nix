{ inputs, ... }:

{
    flake.modules.homeManager.IDE = { config, pkgs, ... }: let 
        continue_config = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/sysconfig/modules/user/IDE/continue/continue.yml";
    in {
        programs.vscode = {
            enable = true;
            profiles.default.extensions = with pkgs.vscode-extensions; [
                ms-vscode-remote.remote-ssh
                christian-kohler.path-intellisense
                hediet.vscode-drawio
                pkief.material-icon-theme
                continue.continue

                # markdown
                yzhang.markdown-all-in-one
                shd101wyy.markdown-preview-enhanced

                # nix
                bbenoist.nix
                
                # python
                ms-python.python
                ms-toolsai.jupyter
            ];
        };
        home.file.".continue/config.yaml".source = continue_config;
    };
}