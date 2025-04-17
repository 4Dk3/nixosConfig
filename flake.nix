{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... } @ inputs:
    
    let
 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

    in

    {

    nixosConfigurations = {
      powr4e = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [

          # Main config
          ./hosts/laptop/configuration.nix

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs.flake-inputs = inputs;
            home-manager.users.powr4e.imports = [
              
              # Home Manager Configuration.
              ./home/home.nix

              # Flatpaks configuration the declarative way.
              nix-flatpak.homeManagerModules.nix-flatpak

            ];
          }

          # Nix Flatpak
          nix-flatpak.nixosModules.nix-flatpak

        ];
      };
    };
  };
}
