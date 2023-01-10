{ pkgs, ... }: {
  home.username = "ardfard";
  home.homeDirectory = "/home/ardfard";
  home.stateVersion = "22.11";
  home.packages = [
    pkgs.tmux
    pkgs.rnix-lsp
  ];
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
    dotDir = ".config/zsh";

    history = {
      size = 10000;
    };
  };
}
