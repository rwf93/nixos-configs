{...}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      nvchad = prev.callPackage ../packages/nvchad { };
    })
  ];
}
