{
  description = "rwf93 NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = { 
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    mkConfig = device:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit system nixpkgs inputs;
          deviceConfig.hostName = device;
        };

        modules = [
          home-manager.nixosModules.home-manager
	  agenix.nixosModules.default
	  nur.nixosModules.nur
	  ./common
          ./devices/${device}/configuration.nix
        ];
      };
  in {
    inherit inputs;

    nixosConfigurations = {
      poise = mkConfig "poise";
    };
  };
}
