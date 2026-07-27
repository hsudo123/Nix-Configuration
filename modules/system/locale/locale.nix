{ inputs, ... }:

{
    flake.modules.darwin.locale = { pkgs, ... }: {
        fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
        ];

        time.timeZone = "Asia/Taipei";
    };

    flake.modules.nixos.locale = { pkgs, ... }: {
        fonts.packages = with pkgs; [
            nerd-fonts.jetbrains-mono
        ];

        # Set your time zone.
        time.timeZone = "Asia/Taipei";

        # Select internationalisation properties.
        i18n.defaultLocale = "zh_TW.UTF-8";

        i18n.extraLocaleSettings = {
            LC_ADDRESS = "zh_TW.UTF-8";
            LC_IDENTIFICATION = "zh_TW.UTF-8";
            LC_MEASUREMENT = "zh_TW.UTF-8";
            LC_MONETARY = "zh_TW.UTF-8";
            LC_NAME = "zh_TW.UTF-8";
            LC_NUMERIC = "zh_TW.UTF-8";
            LC_PAPER = "zh_TW.UTF-8";
            LC_TELEPHONE = "zh_TW.UTF-8";
            LC_TIME = "zh_TW.UTF-8";
        };

        # Configure keymap in X11
        services.xserver.xkb = {
            layout = "tw";
            variant = "";
        };

        i18n.inputMethod = {
            type = "fcitx5";
            enable = true;
            fcitx5.addons = with pkgs; [
                rime-data
                fcitx5-rime
                fcitx5-gtk
                kdePackages.fcitx5-qt
            ];
        };
    };
}
