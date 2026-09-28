{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;   # для VS Code

  # Автовход в tty1 -> fish сам запускает Hyprland
  services.getty.autologinUser = "den";

  # Docker
  virtualisation.docker.enable = true;
  users.users.den.extraGroups = [ "docker" ];

  # Файловый менеджер + флешки, корзина, превью
  programs.thunar.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.tumbler.enable = true;

  # Bluetooth-менеджер (апплет в трее)
  services.blueman.enable = true;

  # Нужен для GTK-тем
  programs.dconf.enable = true;
}
