{ pkgs, ... }:
let
  nvimConfig = pkgs.fetchFromGitHub {
    owner = "ardfard";
    repo = ".vim";
    rev = "master";
    sha256 = "sha256-TP96khypXA7pmGU1Q33Dtz2xQjKUfjlL4EVOOUAtO3U=";
  };

  # mvim is a minimal vim
  mvim =
    let
      minimalVim = pkgs.neovim.override {
        configure = {
          customRC = ''
            lua << EOF
              require'nvim-treesitter.configs'.setup {
                highlight = {
                  enable = true
                }
              }
            EOF
          '';
          packages.minimalVim = with pkgs.vimPlugins;{
            start = [ nvim-treesitter.withAllGrammars fzf-vim ];
          };
        };
      };
    in
    pkgs.writeTextFile
      {
        name = "mvim";
        text = ''
          #!${pkgs.bash}/bin/bash
          export XDG_CONFIG_HOME=~/.config/mvim 
          export XDG_DATA_HOME=~/.local/share/mvim 
          ${minimalVim}/bin/nvim "$@"
        '';
        executable = true;
        destination = "/bin/mvim";
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
      gcc
      rust-analyzer
      pyright
      perl
      cachix
      tree
      tmux
      htop
      sumneko-lua-language-server
      terraform-ls
      yaml-language-server
      mvim
      golangci-lint-langserver
      golangci-lint
      gopls
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


}
