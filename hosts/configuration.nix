{ config, lib, pkgs, inputs, user, ... }: {
  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    createHome = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    initialPassword = "letmein";
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
