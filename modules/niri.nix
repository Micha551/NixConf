{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.niri = {
    package = pkgs.niri;
    enable = true;
    settings = {
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
      binds = {
        "Mod+D".action.spawn = "fuzzel";
        "Mod+Return".action.spawn = "emacs";

        "XF86AudioRaiseVolume" = {
          action.spawn = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+" ];
          allow-when-locked = true;
        };

        "XF86AudioLowerVolume" = {
          action.spawn = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-" ];
          allow-when-locked = true;
        };

        "XF86AudioMute" = {
          action.spawn = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];
          allow-when-locked = true;
        };

        "XF86AudioMicMute" = {
          action.spawn = [ "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" ];
          allow-when-locked = true;
        };

        "XF86MonBrightnessUp" = {
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
          allow-when-locked = true;
        };

        "XF86MonBrightnessDown" = {
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];
          allow-when-locked = true;
        };

        "XF86AudioNext" = {
          action.spawn = [ "playerctl next" ];
          allow-when-locked = true;
        };

        "XF86AudioPlay" = {
          action.spawn = [ "playerctl play-pause" ];
          allow-when-locked = true;
        };

        "XF86AudioPrev" = {
          action.spawn = [ "playerctl previous" ];
          allow-when-locked = true;
        };

        "Mod+O" = {
          action.toggle-overview = [];
          repeat = false;
        };

        "Mod+Q" = {
          action.close-window = [];
          repeat = false;
        };

        "Mod+Left".action.focus-column-left = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+B".action.focus-column-left = [];
        "Mod+F".action.focus-column-right = [];
        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+Down".action.move-window-down = [];
        "Mod+Shift+Up".action.move-window-up = [];
        "Mod+Shift+Right".action.move-column-right = [];
        "Mod+Shift+B".action.move-column-left = [];
        "Mod+Shift+N".action.move-window-down-or-to-workspace-down = [];
        "Mod+Shift+P".action.move-window-up-or-to-workspace-up = [];
        "Mod+Shift+F".action.move-column-right = [];
        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Ctrl+Home".action.move-column-to-first = [];
        "Mod+Ctrl+End".action.move-column-to-last = [];
        "Mod+Ctrl+Left".action.focus-monitor-left = [];
        "Mod+Ctrl+Down".action.focus-monitor-down = [];
        "Mod+Ctrl+Up".action.focus-monitor-up = [];
        "Mod+Ctrl+Right".action.focus-monitor-right = [];
        "Mod+Ctrl+B".action.focus-monitor-left = [];
        "Mod+Ctrl+N".action.focus-monitor-down = [];
        "Mod+Ctrl+P".action.focus-monitor-up = [];
        "Mod+Ctrl+F".action.focus-monitor-right = [];
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
        "Mod+Shift+Ctrl+B".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+N".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+P".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+F".action.move-column-to-monitor-right = [];
        "Mod+Page_Down".action.focus-workspace-down = [];
        "Mod+Page_Up".action.focus-workspace-up = [];
        "Mod+N".action.focus-workspace-down = [];
        "Mod+P".action.focus-workspace-up = [];
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [];
        "Mod+Shift+U".action.move-column-to-workspace-down = [];
        "Mod+Shift+I".action.move-column-to-workspace-up = [];
        "Mod+Shift+Page_Down".action.move-workspace-down = [];
        "Mod+Shift+Page_Up".action.move-workspace-up = [];
        "Mod+Ctrl+U".action.move-workspace-down = [];
        "Mod+Ctrl+I".action.move-workspace-up = [];
        "Mod+WheelScrollRight".action.focus-column-right = [];
        "Mod+WheelScrollLeft".action.focus-column-left = [];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];
        "Mod+BracketLeft".action.consume-or-expel-window-left = [];
        "Mod+BracketRight".action.consume-or-expel-window-right = [];
        "Mod+Comma".action.consume-window-into-column = [];
        "Mod+Period".action.expel-window-from-column = [];
        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Shift+R".action.switch-preset-window-height = [];
        "Mod+Ctrl+R".action.reset-window-height = [];
        "Mod+F11".action.maximize-column = [];
        "Mod+Shift+F11".action.fullscreen-window = [];
        "Mod+C".action.center-column = [];
        "Mod+V".action.toggle-window-floating = [];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];
        "Mod+W".action.toggle-column-tabbed-display = [];
        "Print".action.screenshot = [];
        "Ctrl+Print".action.screenshot-screen = [];
        "Alt+Print".action.screenshot-window = [];
        "Mod+Shift+M".action.quit = [];
        "Ctrl+Alt+Delete".action.quit = [];
        "Mod+Shift+K".action.power-off-monitors = [];
      };

      spawn-at-startup = [
        { argv = [ "noctalia-shell" ]; }
      ];

      input = {
        keyboard.xkb = {
          layout = "de";
          options = "caps:ctrl_modifier";
        };
      };

      layout = {
        gaps = 8;
        background-color = "transparent";
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        focus-ring = {
          enable = true;
          active.color = "#ad44edee";
          inactive.color = "#595959aa";
        };
      };

      window-rules = [
        {
          geometry-corner-radius = 
          let
            r = 12.;
          in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
          clip-to-geometry = true;
          draw-border-with-background = false;
          default-column-width = { proportion = 0.5; };
        }
        {
          matches = [
            { title = "Firefox"; }
            { title = "Obsidian"; }
          ];
          open-maximized = true;
        }
        {
          matches = [ { title = "Emacs"; } ];
          open-fullscreen = true;
        }
        {
          matches = [
            { app-id = "r#\"^org\.keepassxc\.KeePassXC$\"#"; }
            { app-id = "r#\"^org\.gnome\.World\.Secrets$\"#"; }
          ];
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}
