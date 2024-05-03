{
  pkgs,
  home-manager,
  ...
}: {
  home-manager.users.rwf93 = { 
    home.stateVersion = "23.11";
    programs = {
      git = {
        enable = true;
	userName = "rwf93";
	userEmail = "22036195+rwf93@users.noreply.github.com";
      };
    };
  };
}
