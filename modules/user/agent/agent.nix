{ inputs, ... }:

{
    flake.modules.homeManager.agent = { config, pkgs, ... }: let
        hermes_config = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/sysconfig/modules/user/agent/hermes";
    in {
        home.packages = [
            inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];

        home.file.".hermes".source = hermes_config;
    };
}