{ pkgs, ... }:
{
  # Stylix красит всё сам; эти цели оставляем со своими настройками
  stylix.targets.waybar.enable = false;    # у waybar свой CSS, уже в Tokyo Night
  stylix.targets.hyprlock.enable = false;  # у hyprlock свои настройки

  # Иконки Stylix не задаёт — оставляем Papirus
  gtk.iconTheme = { name = "Papirus-Dark"; package = pkgs.papirus-icon-theme; };
}
