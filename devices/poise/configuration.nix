# Edit this configuration fi[Ble to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }: {
 # Use the systemd-boot EFI boot loader.

  boot = {
    kernelParams = [ "acpi_enforce_resources=lax" ];
    kernelModules = [ "i2c-dev" "i2c-piix4" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };

  imports = [     
    ./hardware-configuration.nix
    ./audio.nix
    ./video.nix
    ./secrets.nix
    ./users
  ];
  
  services.hardware.openrgb.enable = true;
  hardware.i2c.enable = true;

  services.nfs.server = {
    enable = true;
    exports = ''
      /export/rootfs *(rw,async,no_root_squash,no_subtree_check,insecure)
      /export/rootfs-gentoo *(rw,async,no_root_squash,no_subtree_check,insecure) 
      /export/rootfs-adelie *(rw,async,no_root_squash,no_subtree_check,insecure)  
    '';
  };
  # dumb hack imho
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    lua-language-server
  ];
   
  services.atftpd.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  networking.firewall.enable = false;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

