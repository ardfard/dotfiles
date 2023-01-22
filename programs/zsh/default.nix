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
      mvim = "XDG_CONFIG_HOME=~/.config/mvim XDG_DATA_HOME=~/.local/share/mvim/ nvim";
    };
    initExtra = ''
      if [ -z "$SSH_AUTH_SOCK" ];
        then
        eval $(ssh-agent -s)
        ssh-add
      fi
      . /home/ardfard/.nix-profile/etc/profile.d/nix.sh
      tmux new -s default
    '';
    history = {
      size = 10000;
    };
  };

}
