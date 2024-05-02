{
  config,
  pkgs,
  home-manager,
  ...
}: {
  imports = [
    ./home.nix
  ];

  users.users.rwf93 = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "video"
      "render"
    ];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJO4bJlRW7X9bytFCVWD/TweFqxgSHA2YcDISLpTSXI1FcXWZjZKKYhb/rEyjXneaxl4TcoW381Nc0pphzTz4VNe13GqZ0mF7r0NDnKA94XZcDKd3djDzBbslMdtVtxIgxVovbMysMndwHqZL6Qsp/m+eo0DKj/8mDT0vokiriyLL5M4ldkXxGnUjjNZ6QsLLCRw0EsuXO1TC2ZSsB4TjeM/vQPHcGngBWBBzzHKY0E/tnwxs32/bu7pVe38Q5UIWeFFar0xN/R6ctjfMIuIVp34uP51cL5hQ94O7U0YRPoJ+T+1544wJT3+GhX4ykEKxDl7SI0ZpMcPqPgnNE/8fcO6tMRnfUKGEMACagVrnsp9Kq71Mqp2Qy1ksXzV5pYdPcC+UtrLQULPVoVszBBIBA9XtLkB9WK9ZIph+pUCdQndIuDIUgkvr4geCoT0L6qktuPA+GuiPbxq5w05E5AR3WCrkRepkzyDTtBTAMPCP/X6BbUPrngIfxDql7KisN4RSEWDnlOGud8y2G8kCQxgI2K/QtMVOyyYVJskDaNQ0Tg4DH4wmL3Xq3JR7vJURFcY7Ml31Foqwfd3wfgIzeNsm3Vc+IEN7sC5YeEWfO/s8tKFSJWnkHng0FKdtE95CnhRNXL82gIsW2vGvtOcXpSdhjMe1ka/vYqmKxFq6b/qA9oQ=="];
  };
}
