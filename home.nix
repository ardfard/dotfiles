{pkgs, ...}: {
  home.username = "ardfard";
  home.homeDirectory = "/home/ardfard";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
}
