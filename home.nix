{ pkgs, ... }:
let nvimConfig = pkgs.fetchFromGitHub {
  owner = "ardfard";
  repo = ".vim";
  rev = "master";
  sha256 = "sha256-TP96khypXA7pmGU1Q33Dtz2xQjKUfjlL4EVOOUAtO3U=";
};
in
{

  programs.home-manager.enable = true;

  imports = [ ./modules/AstroNvim.nix ] ++ (builtins.concatMap import [
    ./programs
  ]);

  home = {
    username = "ardfard";
    homeDirectory = "/home/ardfard";
    stateVersion = "22.11";
    packages = with pkgs; [
      rnix-lsp
      perl
      cachix
      tree
      tmux
      htop
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -la";
      l = "ls -CF";
      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
    };

    file.".tmux.conf".source = pkgs.fetchFromGitHub
      {
        owner = "gpakosz";
        repo = ".tmux";
        rev = "master";
        sha256 = "sha256-bA0da2nIIEQUCtervsiZLNQ2V6+OizBr8Uqz94sGV1A=";
      } + "/.tmux.conf";
    file.".tmux.conf.local".source = ./.tmux.conf.local;

  };

  xdg = {
    enable = true;
    configHome = "/home/ardfard/.config";
  };

  systemd.user = { tmpfiles = { rules = [ "L+ /lib/${builtins.baseNameOf pkgs.stdenv.cc.bintools.dynamicLinker} - - - - ${pkgs.stdenv.cc.bintools.dynamicLinker}" "L+ /lib64 - - - - /lib" ]; }; };

}
