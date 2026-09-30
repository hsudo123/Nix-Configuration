{ inputs, ... }:

{
    flake.modules.homeManager.agent = { config, pkgs, ... }: let
        omlx = pkgs.stdenvNoCC.mkDerivation rec {
            pname = "oMLX";
            version = "0.6.4";

            src = pkgs.fetchurl {
                url = "https://github.com/jundot/omlx/releases/download/v${version}/oMLX-${version}-macos26-27.dmg";
                sha256 = "sha256-U/FQbCOF6JIKZxmLctH+CTUcGzU4vpxr3reOUnfQbZM="; 
            };

            nativeBuildInputs = [  ];

            unpackPhase = ''
                MOUNT_POINT=$(mktemp -d)
                /usr/bin/hdiutil attach "$src" -mountpoint "$MOUNT_POINT" -nobrowse -quiet

                mkdir -p source
                cp -R "$MOUNT_POINT"/*.app source/

                /usr/bin/hdiutil detach "$MOUNT_POINT" -quiet
                rm -rf "$MOUNT_POINT"

                cd source

                # 7zz x $src -oout
            '';

            installPhase = ''
                mkdir -p $out/Applications
                cp -R *.app $out/Applications/

                # APP_PATH=$(find out -maxdepth 3 -iname "*.app" -type d | head -n 1)
                # if [ -n "$APP_PATH" ]; then
                #     cp -R "$APP_PATH" "$out/Applications/"
                # else
                #     echo "Error: Could not find .app directory inside DMG"
                #     exit 1
                # fi
            '';
        };

        config_folder = "${config.home.homeDirectory}/sysconfig/modules/user/agent";
        dotfiles = config.lib.file.mkOutOfStoreSymlink "${config_folder}/hermes";
        hermes_config = config.lib.file.mkOutOfStoreSymlink "${config_folder}/hermes.yaml";
    in {
        imports = [ inputs.hermes-agent.homeManagerModules.default ];

        home.packages = with pkgs;[
        ] ++ pkgs.lib.optionals (pkgs.stdenv.hostPlatform.system == "aarch64-darwin") [
            omlx
        ];

        home.file.".hermes".source = dotfiles;

        programs.hermes-agent = {
            enable = true;
            desktop.enable = true;
        };

        services.hermes-agent = {
            enable = true;
            configFile = hermes_config;
            gateway.enable = true;
            extraDependencyGroups = [ "messaging" ];
            backend.mode = "dashboard"; # + the browser dashboard on 127.0.0.1:9119
            backend.port = 9119;
            environment = {
                SEARXNG_URL = "http://127.0.0.1:55688";
                HERMES_ALLOW_PRIVATE_IPS = "true";
            };
        };
    };
}