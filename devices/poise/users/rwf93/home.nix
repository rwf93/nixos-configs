{
  pkgs,
  home-manager,
  ...
}: 
let 
  mod = "Mod1";
in
{
  programs.fish.enable = true;
  users.users.rwf93.shell = pkgs.fish;
  home-manager.users.rwf93 = { 
    programs = {
      kitty = {
        enable = true;
	font = {
	  name = "JetBrainsMono NF Regular";
	  size = 12;
	};
      };
      firefox.enable = true;
      fish = {
        enable = true;
      };
    };
 
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      awesome
    ];

    xsession.enable = true;
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;
        bars = [
          {
	    position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${./i3status-rust.toml}"; 	   
          }
        ];
      };
    };	
  };
}

