{ config, pkgs, ... }: {
  programs.astronvim = {
    enable = true;
    userConfig = ./config;
  };
}
