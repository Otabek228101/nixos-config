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
        touchpad = { natural_scroll = true; tap-to-click = true; };
      };

      gesture = [ "3, horizontal, workspace" ];

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "rgb(7aa2f7)";
        "col.inactive_border" = "rgb(2a2e3f)";
        layout = "dwindle";
      };

      decoration = {
        rounding = 4;
        blur.enabled = false;
        shadow.enabled = false;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        background_color = "rgb(1a1b26)";
      };

      bind = [
        "$mod, Return, exec, kitty"
        "$mod, D, exec, fuzzel"
        "$mod, B, exec, firefox"
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
          "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
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
