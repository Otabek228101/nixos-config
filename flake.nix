{
  description = "Den's NixOS laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { nixpkgs, home-manager, zen-browser, stylix, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/laptop/configuration.nix   # твой родной конфиг из /etc/nixos
        ./modules/desktop.nix              # Hyprland, звук, шрифты, ноутбучное
        ./modules/extras.nix               # Docker, автовход, Thunar, Bluetooth-трей
        ./modules/theme.nix                # Stylix: Tokyo Night для всего
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";
          home-manager.users.den = import ./home/home.nix;
          home-manager.extraSpecialArgs = {
            zen = zen-browser.packages.x86_64-linux.default;
          };
        }
      ];
    };
  };
}
