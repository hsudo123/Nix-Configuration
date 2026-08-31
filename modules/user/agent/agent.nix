{ inputs, ... }:

{
    flake.modules.homeManager.agent = { config, pkgs, ... }: let
        dotfiles = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/sysconfig/modules/user/agent/hermes";
        hermes_config = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/sysconfig/modules/user/agent/config.yaml";
    in {
        imports = [ inputs.hermes-agent.homeManagerModules.default ];

        home.file.".hermes".source = dotfiles;

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
        programs.hermes-agent.desktop.enable = true;
    };
}