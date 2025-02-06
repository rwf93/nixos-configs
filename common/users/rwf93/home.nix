{
  pkgs,
  home-manager,
  config,
  ...
}: {
  home-manager.users.rwf93 = { 
    home.stateVersion = "23.11";
    programs = {
      git = {
        enable = true;
        userName = "rwf93";
        userEmail = "22036195+rwf93@users.noreply.github.com";
        package = pkgs.gitFull;
        extraConfig = {
          credential = {
            credentialStore = "secretservice";
            helper = "${pkgs.nur.repos.utybo.git-credential-manager}/bin/git-credential-manager";
          };
        };
      };
    };
  };
}
