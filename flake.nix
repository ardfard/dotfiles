{
  description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {nixpkgs, home-manager, ...}: {
        defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

        homeConfigurations = {
            "ardfard" = home-manager.lib.homeManagerConfiguration {

                pkgs = nixpkgs.legacyPackages.x86_64-linux;

                modules = [ ./home.nix ];
            };
        };
    };
}
