let
  more = {
    programs = { pkgs, ... }: {
      git = {
        enable = true;
        userName = " ardfard ";
        userEmail = " ardfarde@gmail.com";
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
        tmux.enableShellIntegration = true;
      };

      jq.enable = true;


    };
  };
in
[
  ./zsh
  more
]
