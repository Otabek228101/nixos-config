{ pkgs, zen, ... }:
{
  imports = [ ./hyprland.nix ./waybar.nix ./extras.nix ./theme.nix ];

  home.username = "den";
  home.homeDirectory = "/home/den";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    zen                 # основной браузер
    firefox             # запасной, можно убрать
    bitwarden-desktop
    telegram-desktop
    brightnessctl playerctl pavucontrol
    grim slurp wl-clipboard
  ];

  programs.git.enable = true;

  # Zen — браузер по умолчанию
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
    };
  };

  # Автозапуск Hyprland при логине в tty1
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if test (tty) = /dev/tty1; and not set -q WAYLAND_DISPLAY
        exec Hyprland
      end
    '';
  };

  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = 8;
      confirm_os_window_close = 0;
    };
  };

  programs.fuzzel = {
    enable = true;
    settings.main.width = 40;
  };

  services.mako = {
    enable = true;
    settings = { default-timeout = 5000; border-radius = 4; };
  };

  # Блокировка экрана и сон
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [ { color = "rgb(1a1b26)"; } ];
      input-field = [ { size = "250, 50"; position = "0, 0"; halign = "center"; valign = "center"; } ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        { timeout = 300; on-timeout = "loginctl lock-session"; }
        { timeout = 600; on-timeout = "systemctl suspend"; }
      ];
    };
  };
}
