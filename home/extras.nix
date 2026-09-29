{ pkgs, ... }:
let
  wallpaper = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
in
{
  home.packages = with pkgs; [
    vscode
    docker-compose
    btop ripgrep fd jq curl unzip
    moonlight-qt
  ];

  # --- Dev ---
  programs.git.settings = {
    user.name = "Otabek228101";
    user.email = "bekotabekbek56@gmail.com";
    init.defaultBranch = "main";
  };
  programs.gh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # --- Трей: Wi-Fi и Bluetooth ---
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;

  # --- История буфера обмена (Super+V) ---
  services.cliphist.enable = true;

  # --- Ночной режим (координаты Ташкента, поправь под свой город) ---
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 41.3;
    longitude = 69.3;
    temperature = { day = 6500; night = 3700; };
  }

  # --- Hyprland: обои, курсор, новые хоткеи ---
  wayland.windowManager.hyprland.settings = {
    env = [ "XCURSOR_THEME,Bibata-Modern-Classic" "XCURSOR_SIZE,24" ];
    exec-once = [ "${pkgs.swaybg}/bin/swaybg -m fill -i ${wallpaper}" ];
    bind = [
      "$mod, E, exec, thunar"
      "$mod, C, exec, code"
      "$mod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
    ];
  };
}

