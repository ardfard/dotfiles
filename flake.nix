{
  description = "ardfard Nixos Flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs =
    let
      user = "ardfard";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        config.allowUnfree = true;
      };
    in
    { self, nixpkgs, home-manager, flake-utils, ... }: {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      nixosConfigurations = (
        import ./hosts {
          inherit (pkgs) lib;
          inherit inputs pkgs home-manager user;
        }
      );

      homeConfigurations = {
        ${user} = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;

          modules = [ ./home.nix ];
        };
      };
    };
}
