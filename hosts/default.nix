{ inputs, nixpkgs, home-manager, user, system, ... }:
let pkgs = import nixpkgs {
  inherit system;
  config.allowUnfree = true;
};
in
{
  wsl = lib.nixosSystem {

    inherit system;

    specialArgs = {
      inherit inputs;
    };

    modules = [
      ./wsl
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager-useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
          host = {
            hostName = "nixos-wsl";
          };
        };
        home-manager.users.${user} = {
          imports = [ (import ../home.nix) ];
        };
      }
    ];
  };
}
