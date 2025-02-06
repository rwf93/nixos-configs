{...}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  nixpkgs.config.allowInsecurePredicate = _: true;
  nixpkgs.overlays = [
    (final: prev: {
      nvchad = prev.callPackage ../packages/nvchad { };
    })
  ];
}
