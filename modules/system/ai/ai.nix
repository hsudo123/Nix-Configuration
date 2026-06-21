{ inputs, ... }:

{
    flake.modules.darwin.ai = let
        ENV_VAR = {
            OLLAMA_MODELS = "/Volumes/CrucialX6/ollama";
            OLLAMA_KEEP_ALIVE = "1m";
            OLLAMA_FLASH_ATTENTION = "1";
        };
    in {
        homebrew = {
            casks = [
                "ollama-app"
                "anythingllm"
            ];
        };

        environment.variables = ENV_VAR;
        launchd.user.agents.ollama-service = {
            serviceConfig = {
                ProgramArguments = [ "/Applications/Ollama.app/Contents/Resources/ollama" "serve" ];
                RunAtLoad = true;
                ProcessType = "Standard";
                EnvironmentVariables = ENV_VAR; # 🎯 精準注入
                StandardOutPath = "/dev/null"; # 請確認 hanyu 資料夾下有建立對應目錄
                StandardErrorPath = "/dev/null";
            };
        };
    };
}