{
  description = "rwf93 NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nur,  
    home-manager,
    agenix,
    stylix,
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
        nur.modules.nixos.default 
        home-manager.nixosModules.home-manager
        agenix.nixosModules.default
        stylix.nixosModules.stylix 
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
