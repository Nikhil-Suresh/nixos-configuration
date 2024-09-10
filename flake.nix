{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.runesmith = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/common_configuration.nix
          ./hosts/runesmith/configuration.nix
          ./hosts/runesmith/hardware-configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      nixosConfigurations.apprentice = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/common_configuration.nix
          ./hosts/apprentice/configuration.nix
          ./hosts/apprentice/hardware-configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };

    };
}
