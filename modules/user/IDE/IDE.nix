{ inputs, ... }:

{
    flake.modules.homeManager.IDE = { config, pkgs, ... }: let 
        IDE_prefix = "${config.home.homeDirectory}/sysconfig/modules/user/IDE";
        continue_config = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/continue/continue.yml";
        template = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/template/template.txt";
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
        home.file."Library/Application Support/Code/User/snippets/template.code-snippets".source = template;
    };
}