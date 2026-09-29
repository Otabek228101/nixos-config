{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main = {
      layer = "top";
      position = "top";
      height = 30;
      margin-top = 6;
      margin-left = 10;
      margin-right = 10;

      modules-left = [ "custom/nix" "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "tray" "hyprland/language" "backlight" "pulseaudio" "network" "battery" ];

      "custom/nix" = {
        format = "";
        tooltip = false;
        on-click = "fuzzel";
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = { default = ""; active = ""; };
        persistent-workspaces = { "*" = 5; };
      };

      clock = {
        format = "󰥔 {:%H:%M}";
        format-alt = "󰃭 {:%d.%m.%Y}";
        tooltip-format = "<tt>{calendar}</tt>";
      };

      tray.spacing = 8;

      "hyprland/language".format = "󰌌 {short}";

      backlight = {
        format = "{icon} {percent}%";
        format-icons = [ "󰃞" "󰃟" "󰃠" ];
        on-scroll-up = "brightnessctl s 5%+";
        on-scroll-down = "brightnessctl s 5%-";
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = "󰝟 muted";
        format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
        on-click = "pavucontrol";
      };

      network = {
        format-wifi = "{icon} {essid}";
        format-icons = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-ethernet = "󰈀 eth";
        format-disconnected = "󰤮 offline";
        tooltip-format-wifi = "{signalStrength}%  {ipaddr}";
      };

      battery = {
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        states = { warning = 20; critical = 10; };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar { background: transparent; color: #c0caf5; }

      /* «пилюли» */
      #custom-nix, #workspaces, #clock, #tray, #language,
      #backlight, #pulseaudio, #network, #battery {
        background: #1a1b26;
        border: 1px solid #292e42;
        border-radius: 12px;
        padding: 2px 12px;
        margin: 0 3px;
      }

      #custom-nix { color: #7aa2f7; font-size: 16px; padding: 2px 14px 2px 10px; }

      #workspaces { padding: 2px 6px; }
      #workspaces button {
        padding: 0 5px;
        color: #565f89;
        background: transparent;
        box-shadow: none;
        text-shadow: none;
      }
      #workspaces button.active { color: #7aa2f7; }
      #workspaces button.urgent { color: #f7768e; }
      #workspaces button:hover { background: #292e42; border-radius: 8px; }

      #clock      { color: #bb9af7; }
      #language   { color: #c0caf5; }
      #backlight  { color: #e0af68; }
      #pulseaudio { color: #7dcfff; }
      #pulseaudio.muted { color: #565f89; }
      #network    { color: #9ece6a; }
      #network.disconnected { color: #f7768e; }
      #battery    { color: #9ece6a; }
      #battery.charging { color: #7aa2f7; }
      #battery.warning:not(.charging)  { color: #e0af68; }
      #battery.critical:not(.charging) { color: #f7768e; }

      tooltip {
        background: #1a1b26;
        border: 1px solid #292e42;
        border-radius: 10px;
      }
    '';
  };
}
