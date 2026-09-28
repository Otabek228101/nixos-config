{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  security.polkit.enable = true;
  security.pam.services.hyprlock = { };

  # Intel UHD: аппаратное декодирование видео
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver vpl-gpu-rt ];
  };

  # Звук
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Сеть, Bluetooth, питание
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  users.users.den.extraGroups = [ "networkmanager" "video" ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];
}
