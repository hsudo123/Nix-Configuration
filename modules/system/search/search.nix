{ inputs, ... }:

{
    flake.modules.darwin.search = { pkgs, ... }: let
        searxng = pkgs.searxng;
        ENV_VAR = {
            SEARXNG_SETTINGS_PATH = "/Users/hanyu/sysconfig/modules/system/search/searxng/settings.yml";
        };
    in {
        environment.systemPackages = [ searxng ];
        
        launchd.user.agents.searxng = {
            serviceConfig = {
                ProgramArguments = [ "${searxng}/bin/searxng-run" ];
                RunAtLoad = true;
                ProcessType = "Standard";
                EnvironmentVariables = ENV_VAR; # 🎯 精準注入
                StandardOutPath = "/dev/null"; # 請確認 hanyu 資料夾下有建立對應目錄
                StandardErrorPath = "/dev/null";
            };
        };
    };
}