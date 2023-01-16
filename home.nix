{ pkgs, ... }:
let nvimConfig = pkgs.fetchFromGitHub {
  owner = "ardfard";
  repo = ".vim";
  rev = "master";
  sha256 = "sha256-TP96khypXA7pmGU1Q33Dtz2xQjKUfjlL4EVOOUAtO3U=";
};
in
{

  home =
    {
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
        neovim
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

      file.".config/vimrc".source = nvimConfig;
      file.".vimrc".source = nvimConfig + "/.vimrc";

    };

  xdg = {
    enable = true;
    configHome = "/home/ardfard/.config";
    configFile."nvim/init.vim".source = nvimConfig + "/.vimrc";
    configFile."nvim/site/autoload/plug.vim".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
      sha256 = "sha256-4tvXyNcyrnl+UFnA3B6WS5RSmjLQfQUdXQWHJ0YqQ/0=";
    };
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = " ardfard ";
    userEmail = " ardfarde@gmail.com";
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
    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      e = "nvim";
    };
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


