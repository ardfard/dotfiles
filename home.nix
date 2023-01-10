{pkgs, ...}: {
  home.username = "ardfard";
  home.homeDirectory = "/home/ardfard";
  home.stateVersion = "22.11";
  home.packages = [
    pkgs.tmux
    pkgs.rnix-lsp
  ];
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
}
