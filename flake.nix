{
  description = "Den's NixOS laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/laptop/configuration.nix   # твой родной конфиг из /etc/nixos
        ./modules/desktop.nix              # Hyprland, звук, шрифты, ноутбучное
        ./modules/extras.nix               # Docker, автовход, Thunar, Bluetooth-трей
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.users.den = import ./home/home.nix;
        }
      ];
    };
  };
}
