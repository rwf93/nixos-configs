{
  config,
  ...
}: {
  imports = [ 
    ./home.nix
  ];

  users.users.rwf93.hashedPasswordFile = config.age.secrets.rwf93-passwd.path;
}
