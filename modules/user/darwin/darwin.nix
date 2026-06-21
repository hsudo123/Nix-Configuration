{ inputs, ... }:

{
    flake.modules.homeManager.darwin = {
        home.username = "hanyu";
	    home.homeDirectory = "/Users/hanyu";
        home.stateVersion = "26.05";

        # 🎯 設定 1：主設定檔，將小鶴雙拼設為唯一/預設方案
        home.file."Library/Rime/default.custom.yaml".source = ./double_pinyin/default.custom.yaml;
        # 🎯 設定 2：小鶴雙拼的個性化客製檔（實現強制繁體中文輸出 🇹🇼）
        home.file."Library/Rime/double_pinyin_flypy.custom.yaml".source = ./double_pinyin/double_pinyin_flypy.custom.yaml;
        # 🎯 設定 3：透過 Nix 宣告式下載官方的小鶴雙拼 Schema 方案原始碼
        home.file."Library/Rime/double_pinyin_flypy.schema.yaml".source = ./double_pinyin/double_pinyin_flypy.schema.yaml;
    };
}