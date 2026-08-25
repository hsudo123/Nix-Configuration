{ inputs, ... }:

{
    flake.modules.homeManager.IDE = { config, pkgs, ... }: let 
        official_extension = with pkgs.vscode-extensions; [
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
        ];
        thirdparty_extension = with pkgs; [
            open-vsx.jeanp413.open-remote-ssh
            open-vsx.detachhead.basedpyright
        ];

        IDE_prefix = "${config.home.homeDirectory}/sysconfig/modules/user/IDE";

        continue_config = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/continue/continue.yml";
        user = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/settings/user.json";
        template = config.lib.file.mkOutOfStoreSymlink "${IDE_prefix}/settings/template.txt";

        vscodiumUserDir = if pkgs.stdenv.hostPlatform.isDarwin then "Library/Application Support/VSCodium/User" else ".config/VSCodium/User";
    in {
        nixpkgs.overlays = [
            inputs.nix-vscode-extensions.overlays.default
        ];

        programs.vscodium = {
            enable = true;
            package = pkgs.vscodium;
            profiles.default.extensions = official_extension ++ thirdparty_extension;
        };
        home.file.".continue/config.yaml".source = continue_config;
        home.file."${vscodiumUserDir}/settings.json".source = user;
        home.file."${vscodiumUserDir}/snippets/template.code-snippets".source = template;
    };
}