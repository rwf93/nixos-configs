{
  pkgs,
  home-manager,
  lib,
  config,
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
      nix-index = {
        enable = true;
	enableFishIntegration = true;
      };
      
      kitty = {
        enable = true;
	font = {
	  name = "JetBrainsMono NF Regular";
	  size = 12;
	};
      };
      
      rofi = {
        enable = true;
        theme = "Arc-Dark";
      };
      
      firefox = {
        enable = true;
	profiles.default.extensions = with config.nur.repos.rycee.firefox-addons; [
	  ublock-origin
	  sponsorblock
	  dearrow
	  darkreader
	];
      };
      
      fish = {
        enable = true;
        plugins = [
	  {
	    name = "theme-bobthefish";
	    src = pkgs.fetchFromGitHub {
	      owner = "oh-my-fish";
	      repo = "theme-bobthefish";
	      rev = "0c15ff1cbc4bfa026c882e01dd5ceec327f26033";
	      sha256 = "sha256-qSVx0JpXwz28D1YUtc3ujZ16rt+dLbbQ70/2J2wU5bs="; 
	    };
	  }
	];
      };
    };

    services.picom = {
      enable = true;
      fade = true;
      settings = { 
        blur = {
          method = "gaussian";
	  size = 10;
	  deviation = 5.0;
        };
      };

      activeOpacity = 0.8;
      inactiveOpacity = 0.8;
      fadeDelta = 4;
      opacityRules = [
        "100:class_g = 'firefox'"
      ];
    };
    
    fonts.fontconfig.enable = true;
    
    home.packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      awesome
      vesktop
    ];

    xsession.enable = true;
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;
        gaps = {
	  outer = 15;
	  inner= 10;
	};

	keybindings = lib.mkOptionDefault {
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
        };

	bars = [
          {
	    position = "top";
            #statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
          }
        ];
      };
    };	
  };
}

