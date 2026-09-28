{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main = {
      layer = "top";
      position = "top";
      height = 26;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "hyprland/language" "pulseaudio" "network" "battery" "tray" ];

      clock.format = "{:%H:%M  %d.%m}";
      "hyprland/language".format = "{short}";
      pulseaudio = {
        format = "vol {volume}%";
        format-muted = "muted";
        on-click = "pavucontrol";
      };
      network = {
        format-wifi = "{essid}";
        format-ethernet = "eth";
        format-disconnected = "offline";
      };
      battery = {
        format = "bat {capacity}%";
        format-charging = "chg {capacity}%";
        states = { warning = 20; critical = 10; };
      };
    };

    style = ''
      * { font-family: "JetBrainsMono Nerd Font"; font-size: 12px; border: none; border-radius: 0; min-height: 0; }
      window#waybar { background: #1a1b26; color: #c0caf5; }
      #workspaces button { padding: 0 8px; color: #565f89; }
      #workspaces button.active { color: #7aa2f7; }
      #clock, #language, #pulseaudio, #network, #battery, #tray { padding: 0 10px; }
      #battery.warning { color: #e0af68; }
      #battery.critical { color: #f7768e; }
    '';
  };
}
