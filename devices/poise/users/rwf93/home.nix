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

  stylix.enable = true;
  stylix.image = ./wallpapers/wallhaven-wejydr_1920x1080.png;

  home-manager.users.rwf93 = {   
    home.file.".config/nvim".source = ./config/nvim;
    home.file.".config/nvim".recursive = true;

    programs = {  
      neovim.enable = true; 
      nix-index = {
        enable = true;
        enableFishIntegration = true;
      };

      fzf = {
        enable = true;
        enableFishIntegration = true;
      };

      kitty = {
        enable = true;
#        font = {
          #name = "JetBrainsMono NF Regular";
          #size = 12;
#        };
        settings = {
          resize_in_steps = "yes";
        };
      };

      rofi = {
        enable = true;
        #theme = "Arc-Dark";
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
            src = ./config/fish/plugins/theme-bobthefish;
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

        corner-radius = 5;

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
        "95:class_g = 'kitty' && focused"         
        "75:class_g = 'kitty' && focused"         
        "100:name *?= 'minecraft'"
        "100:_NET_WM_STATE@:32a = '_NET_WM_STATE_FULLSCREEN'"
      ];

      shadowExclude = [
        "name ~= 'polybar'"
      ];      
    };

    stylix.cursor.size = 16;

    stylix.fonts.sizes = {
      terminal = 12;
      desktop = 11;
    };

    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    stylix.fonts.monospace = {
      name = "JetBrainsMono NF";
      package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }); 
    };

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
      font-awesome 
      vesktop
      #gcc
      gnumake
      ncurses
      nodejs_22
      unzip
      xclip
      pavucontrol
      neofetch
      clang-tools
      lua-language-server
      minicom
      screen
      htop
      btop
      wget
      zip
      p7zip
      squashfsTools
      github-desktop
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
 
    xsession = {
      enable = true;
      
      windowManager = {
        i3 = {
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
            for_window [class="^.*"] border pixel 2
            '';
        };	
      };
    };
  };
}

