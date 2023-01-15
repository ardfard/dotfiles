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
    let user = "ardfard";
    in
    { self, nixpkgs, home-manager, flake-utils, ... }: {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      nixosConfigurations = (
        import ./hosts {
          inherit (pkgs) lib;
          inherit inputs nixpkgs home-manager user;
        }
      );

      homeConfigurations = {
        ${user} = home-manager.lib.homeManagerConfiguration {

          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [ ./home.nix ];
        };
      };
    };
}
