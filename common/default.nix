{deviceConfig, ...}: {
  imports = [
    ./users
    ./nix.nix
    ./home-manager.nix
  ];

  networking.hostName = deviceConfig.hostName;
}
