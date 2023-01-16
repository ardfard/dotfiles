{ pkgs, ... }:
let
  nvimConfig = pkgs.fetchFromGithub {
    owner = "ardfard";
    repo = ".vimrc";
    rev = "master";
    sha256 = "21cbbf12fdc79cb3de354e020da84e1316d36212";
  };
in
{

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
      vim = nvim;
    };

    file.".tmux.conf".source = pkgs.fetchFromGitHub
      {
        owner = "gpakosz";
        repo = ".tmux";
        rev = "master";
        sha256 = "sha256-bA0da2nIIEQUCtervsiZLNQ2V6+OizBr8Uqz94sGV1A=";
      } + "/.tmux.conf";
    file.".tmux.conf.local".source = ./.tmux.conf.local;

    file.".config/nvim/init.vim".source = nvimConfig + "/.vimrc";
    file.".vimrc".source = nvimConfig + "/.vimrc";

  };

  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.git = {
    enable = true;
    userName = "ardfard";
    userEmail = "ardfarde@gmail.com";
  };

  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "kubectl"
        "gcloud"
      ];
    };
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;
    initExtra = ''
        if [ -z "$SSH_AUTH_SOCK" ];
      then
      eval $(ssh-agent -s)
      ssh-add
      fi
    '';
    history = {
      size = 10000;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
    };
  };
}

