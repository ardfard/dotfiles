{ config, pkgs, ... }: {
  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      theme = "half-life";
      plugins = [
        "git"
        "git-extras"
        "fzf"
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
      export GPG_TTY=$(tty) 
      if [ -z "$SSH_AUTH_SOCK" ];
        then
        eval $(ssh-agent -s)
        ssh-add
      fi
      . /home/ardfard/.nix-profile/etc/profile.d/nix.sh
      if [ -z "$TMUX" ]; then
        tmux new 
      fi
      export PATH=$PATH:$HOME/.local/bin
    '';
    history = {
      size = 10000;
    };
  };

}
