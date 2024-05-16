{deviceConfig, ...}: {
  imports = [
    ./users
    ./nix.nix
    ./home-manager.nix
  ];

  networking.hostName = deviceConfig.hostName;
  services.automatic-timezoned.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.passSecretService.enable = true;
}
