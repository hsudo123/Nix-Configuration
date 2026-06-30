{ inputs, ... }:

{
    flake.modules.homeManager.shell = { pkgs, ... }: let 
        freeOllamaScript = ''
            #!/bin/bash

            # --- Configuration ---
            API_ENDPOINT="http://localhost:11434/api/generate"

            # --- Validation ---
            if [ $# -lt 1 ]; then
                echo "Error: Missing arguments."
                echo "Usage: $0 <model_name> [optional_options]"
                exit 1
            fi

            MODEL_NAME="$1"

            # Construct the JSON payload dynamically. Note that we escape quotes carefully.
            JSON_PAYLOAD="{\"model\": \"$MODEL_NAME\", \"keep_alive\": 0}"

            echo "--- Requesting generation from model: $MODEL_NAME ---"
            echo "Payload being sent: $JSON_PAYLOAD"

            # Execute the curl command. We capture output to a variable or let it stream directly.
            RESPONSE=$(curl -s -X POST \
                "$API_ENDPOINT" \
                -d "$JSON_PAYLOAD")

            # Check the exit status of curl (0 means success in network transfer)
            if [ $? -eq 0 ]; then
                echo ""
                echo "--- API Response ---"
                echo "$RESPONSE" | jq . # Using jq for pretty printing if installed, otherwise just echo
            else
                echo ""
                echo "Error: Curl command failed to communicate with the API."
            fi
        '';
    in {
        home.packages = with pkgs;[
            (writeShellScriptBin "free-ollama" freeOllamaScript)
        ];

        programs.zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            envExtra = ''
                export LANG="zh_TW.UTF-8"
                export LC_ALL="zh_TW.UTF-8"
                # 載入 Apple Silicon Mac 的 Homebrew 環境變數
                if [ -f "/opt/homebrew/bin/brew" ]; then
                    eval "$(/opt/homebrew/bin/brew shellenv)"
                fi
            '';
        };

        programs.git = {
            enable = true;
            settings.user = {
                name = "Hank";
                email = "hsudo.me@protonmail.com";
            };
        };

        programs.fzf = {
            enable = true;
            enableZshIntegration = true;
        };

        programs.starship = {
            enable = true;
            enableZshIntegration = true;
        };
        home.file.".config/starship.toml".source = ./starship.toml;

        programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
            enableZshIntegration = true;
        };
    };
}