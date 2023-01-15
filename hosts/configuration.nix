{ config, lib, pkgs, inputs, user, ... }: {
  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    initialPassword = "letmein";
  };

  home.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -l";
    la = "ls -la";
    l = "ls -CF";
    grep = "grep --color=auto";
    egrep = "egrep --color=auto";
    fgrep = "fgrep --color=auto";
    vim = "nvim";
  };

  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "Asia/Jakarta";
  environment.systemPackages = with pkgs; [ vim git wget ];

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.05";
}
