{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      vim-surround
      vim-repeat
      vim-nix
      nvim-treesitter.withAllGrammars
    ];

    extra-config =
      let
        vimConfig = builtins.map builtins.readFile [
          ./general.vim
          ./moving.vim
          ./text.vim
          ./ui.vim
          ./misc.vim
        ];
        luaConfig = ("lua << EOF\n" + builtins.readFile ./init.lua + "\nEOF");
      in
      builtins.concatStringsSep "\n" (vimConfig ++ [ luaConfig ]);
  };
}
