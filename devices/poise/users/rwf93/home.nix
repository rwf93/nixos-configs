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
    home.file.".config/nvim".source = ./config/nvim;
    home.file.".config/nvim".recursive = true;

    programs = {  
      neovim.enable = true; 
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
        settings = {
          resize_in_steps = "yes";
          background = "#1e222a";
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
        shellInit = ''
          export NIX_LD=$(nix eval --impure --raw --expr 'let pkgs = import <nixpkgs> {}; NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker"; in NIX_LD')
        '';
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
         
        shadow-radius = 5;
        shadow-opacity = 0.25;
        shadow-offset-x = 0.25;
        shadow-offset-y = 1; 
    
        detect-rounded-corners = true;

        backend = "glx";
        experimental-backends = true; 
      };
    
      shadow = true;

      fadeDelta = 10;
      
      activeOpacity = 0.8;
      inactiveOpacity = 0.8;
      opacityRules = [
        "100:class_g = 'firefox'"
        "100:class_g = 'vesktop'" 
      ];

      shadowExclude = [
        "name ~= 'polybar'"
      ];      
    };

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      font-awesome 
      vesktop
      gcc
      gnumake
      ncurses
      nodejs_22
      unzip
      xclip
      pavucontrol
      neofetch
    ];

    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3Support = true;
        alsaSupport = true;
        iwSupport = true;
        githubSupport = true;
      };

      config = ./config/polybar/config.ini;
      script = "polybar main &";
    };

    xsession.enable = true;
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;
        gaps = {
          outer = 25;
          inner = 35;
          smartBorders = "on";
        };

        fonts = {
          names = [ "JetBrainsMono NF" ];
          style = "Medium";
          size = 11.0;
        };
 
        window = {
          border = 0;
        };

        keybindings = lib.mkOptionDefault {
          "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";           
          "${mod}+p" = "exec ${pkgs.flameshot}/bin/flameshot gui -p ~/captures";
        };

        bars = [];
      };
      extraConfig = ''
        for_window [class="^.*"] border pixel 1
      '';
    };	
  };
}

