{
  description = "The nixos dotfiles ever";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
        zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur,  ... }@inputs: {
    nixosConfigurations.john-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [ nur.overlay ];
        }
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.winter = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
