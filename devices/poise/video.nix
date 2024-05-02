{
  pkgs,
  ...
}: {
  services.xserver = { 
    enable = true;
    videoDrivers = [ "nvidia" ];
    excludePackages = with pkgs; [ 
      xterm
    ];
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
   modesetting.enable = true;
   powerManagement.enable = false;
   powerManagement.finegrained = false;
   open = false;
   nvidiaSettings = true;
  };
}
