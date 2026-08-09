{ inputs, ... }:

{
    flake.modules.homeManager.darwin = { pkgs, config, ... }: let
        grammar = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/sysconfig/modules/user/platform/double_pinyin/zh-hant-t-essay-bgc.gram";
    in {
        imports = [
            inputs.mac-app-util.homeManagerModules.default
        ];
        home.username = "hanyu";
	    home.homeDirectory = "/Users/hanyu";
        home.stateVersion = "26.05";
        programs.home-manager.enable = true;

        home.file."Library/Rime/default.custom.yaml".source = ./double_pinyin/default.custom.yaml;
        home.file."Library/Rime/double_pinyin_flypy.custom.yaml".source = ./double_pinyin/double_pinyin_flypy.custom.yaml;
        home.file."Library/Rime/zh-hans-t-essay-bgc.gram".source = grammar;
        home.file."Library/Rime/double_pinyin_flypy.schema.yaml".source = ./double_pinyin/double_pinyin_flypy.schema.yaml;
    };
}