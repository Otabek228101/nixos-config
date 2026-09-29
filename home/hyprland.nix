{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    package = null;        # берём Hyprland из системного модуля
    portalPackage = null;

    settings = {
      "$mod" = "SUPER";
      monitor = ",preferred,auto,1";

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
        numlock_by_default = true;
        touchpad = { natural_scroll = true; tap-to-click = true; };
      };

      gesture = [ "3, horizontal, workspace" ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur.enabled = false;          # размытие выключено ради батареи и плавности
        shadow = {
          enabled = true;
          range = 12;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "smooth, 0.25, 1, 0.5, 1"
          "overshot, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 4, smooth, popin 80%"
          "border, 1, 8, default"
          "fade, 1, 5, smooth"
          "workspaces, 1, 5, smooth, slide"
          "specialWorkspace, 1, 5, smooth, slidevert"
        ];
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };

      bind = [
        "$mod, T, exec, kitty"
        "$mod, Return, exec, kitty"
        "$mod, A, exec, fuzzel"
        "$mod, B, exec, zen-beta"

        # Отдельное пространство (как Super+S в HyDE)
        "$mod, S, togglespecialworkspace, magic"
        "$mod ALT, S, movetoworkspace, special:magic"

        # Рабочие столы как в Windows: Ctrl+Win+стрелки
        "CTRL $mod, left, workspace, r-1"
        "CTRL $mod, right, workspace, r+1"
        "CTRL $mod SHIFT, left, movetoworkspace, r-1"
        "CTRL $mod SHIFT, right, movetoworkspace, r+1"
        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod SHIFT, V, togglefloating"
        "$mod, L, exec, loginctl lock-session"
        "$mod SHIFT, M, exit"
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ] ++ (builtins.concatLists (builtins.genList (i:
        let ws = toString (i + 1); in [
          "$mod, ${ws}, workspace, ${ws}"
          "$mod ALT, ${ws}, movetoworkspace, ${ws}"
        ]) 9));

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
