{ config
, pkgs
, lib
, ...
}:
with lib; let
  cfg = config.programs.astronvim;
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "v2.11.8";
    sha256 = "sha256-fpKrB6LW5KlQx/Egv5QY0hnzDGtJqmaXOzQevllVdjI=";
  };
in
{
  options.programs.astronvim = {
    enable = mkEnableOption "astronvim";

    userConfig = mkOption {
      default = null;
      description = "AstronVim User Config";
      type = with types; nullOr path;
    };

  };

  config = mkIf (cfg.enable)
    {
      home.packages = [ pkgs.neovim ];

      xdg.configFile."nvim" = {
        recursive = true;
        source = astronvim;
      };

      xdg.configFile."nvim/lua/user" = mkIf (cfg.userConfig != null) {
        recursive = true;
        source = cfg.userConfig;
      };

      xdg.dataFile."nvim/site/pack/packer/opt/nvim-treesitter" = {
        recursive = true;
        source = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
      };
    };
}
