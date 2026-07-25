{ inputs, ... }:

{
    flake.modules.darwin.darwin = {
        imports = [
            inputs.mac-app-util.darwinModules.default
        ];

        nixpkgs.hostPlatform = "aarch64-darwin";
        system.stateVersion = 6;
        system.primaryUser = "hanyu";

        security.pam.services.sudo_local.touchIdAuth = true;

        system.defaults = {
            NSGlobalDomain = {
                AppleShowAllExtensions = true;
                AppleShowScrollBars = "Always";
                AppleWindowTabbingMode = "always";
                AppleICUForce24HourTime = true;
                NSNavPanelExpandedStateForSaveMode = true;
                NSNavPanelExpandedStateForSaveMode2 = true;
                PMPrintingExpandedStateForPrint = true;
                PMPrintingExpandedStateForPrint2 = true;
                NSDocumentSaveNewDocumentsToCloud = false;
                ApplePressAndHoldEnabled = false;
                InitialKeyRepeat = 25;
                KeyRepeat = 2;
                "com.apple.mouse.tapBehavior" = 1;
                NSWindowShouldDragOnGesture = true;

                # Disable some auto typing feature
                NSAutomaticCapitalizationEnabled = false;
                NSAutomaticSpellingCorrectionEnabled = false;
                NSAutomaticDashSubstitutionEnabled = false;
                NSAutomaticQuoteSubstitutionEnabled = false;

                # Disable some animation
                NSAutomaticWindowAnimationsEnabled = false;
                NSScrollAnimationEnabled = false;
            };

            menuExtraClock = {
                Show24Hour = true;
                ShowAMPM = false;
            };

            finder = {
                FXPreferredViewStyle = "Nlsv";
                ShowExternalHardDrivesOnDesktop = true;
                ShowHardDrivesOnDesktop = false;
                ShowMountedServersOnDesktop = false;
                ShowRemovableMediaOnDesktop = true;
                _FXSortFoldersFirst = true;
                _FXEnableColumnAutoSizing = true;

                # When performing a search, search the current folder by default
                FXDefaultSearchScope = "SCcf";
                NewWindowTarget = "Home";
                AppleShowAllExtensions = true;
                ShowStatusBar = true;
                ShowPathbar = true;
            };
            
            dock = {
                tilesize = 64;
                autohide = false;
                autohide-delay = 1.5;
                launchanim = false;
                static-only = false;
                show-process-indicators = true;

                wvous-bl-corner = 4;
                wvous-br-corner = 1;
                wvous-tl-corner = 1;
                wvous-tr-corner = 1;
            };

            ActivityMonitor = {
                OpenMainWindow = true;
                IconType = 5;
                SortColumn = "CPUUsage";
                SortDirection = 0;
            };
        };

        system.defaults.CustomUserPreferences = {
            # Avoid creating .DS_Store files on network or USB volumes
            "com.apple.desktopservices" = {
                DSDontWriteNetworkStores = true;
                DSDontWriteUSBStores = true;
            };
            "com.apple.HIToolbox" = {
                AppleEnabledInputSources = [
                    # 1. 原生英文
                    {
                        InputSourceKind = "Keyboard Layout";
                        "KeyboardLayout ID" = 0;
                        "KeyboardLayout Name" = "U.S.";
                        "InputSourceID" = "com.apple.keylayout.US";
                    }
                    # 2. 原生繁體注音輸入法
                    {
                        "Bundle ID" = "com.apple.inputmethod.TCIM";
                        InputSourceKind = "Input Method";
                        "InputSourceID" = "com.apple.inputmethod.TCIM.Zhuyin";
                        "Input Mode" = "com.apple.inputmethod.TCIM.Phonetic";
                    }
                    # 3. 第三方 鼠鬚管輸入法
                    {
                        "Bundle ID" = "im.rime.inputmethod.Squirrel";
                        InputSourceKind = "Input Method";
                        "InputSourceID" = "im.rime.inputmethod.Squirrel";
                    }
                ];
            };
        };

        homebrew = {
            casks = [
                "squirrel-app"
            ];
        };
    };
}