{ config, pkgs, ... }: {
  programs.astronvim = {
    enable = true;
    userConfig = ./init.lua;
  };
}
