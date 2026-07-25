{ inputs, ... }:

{
    flake.modules.homeManager.IDE = { config, pkgs, ... }: let 
        IDE_prefix = "${config.home.homeDirectory}/sysconfig/modules/user/IDE";
        continue_config = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/continue/continue.yml";
        user = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/settings/user.json";
        template = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/settings/template.txt";
    in {
        nixpkgs.overlays = [
            inputs.nix-vscode-extensions.overlays.default
        ];

        programs.vscodium = {
            enable = true;
            package = pkgs.vscodium;
            profiles.default.extensions = (with pkgs.vscode-extensions; [
                ms-ceintl.vscode-language-pack-zh-hant
                # ms-vscode-remote.remote-ssh
                christian-kohler.path-intellisense
                mkhl.direnv
                hediet.vscode-drawio
                pkief.material-icon-theme
                continue.continue

                # markdown
                yzhang.markdown-all-in-one
                shd101wyy.markdown-preview-enhanced

                # nix
                bbenoist.nix

                # c/c++
                ms-vscode.cpptools-extension-pack
                llvm-vs-code-extensions.vscode-clangd

                # python
                ms-python.python
                ms-toolsai.jupyter
            ]) ++ [
                pkgs.open-vsx.jeanp413.open-remote-ssh
            ];
        };
        home.file.".continue/config.yaml".source = continue_config;
        home.file."Library/Application Support/VSCodium/User/settings.json".source = user;
        home.file."Library/Application Support/VSCodium/User/snippets/template.code-snippets".source = template;
    };
}