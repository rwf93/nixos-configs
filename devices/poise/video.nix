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
    displayManager.lightdm.enable = true; 
    displayManager.session = [
      {
        manage = "desktop";
        name = "xsession";
        start = ''exec $HOME/.xsession'';
      }
    ];
    #displayManager.setupCommands = ''
    #  ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --mode 1920x1080 --primary --rate 170 --output DP-4 --mode 2560x1440 --right-of DP-2
    #'';
  };

  hardware.opengl = {
    enable = true;
#    driSupport = true;
#    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };
}
