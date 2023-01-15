{ inputs, pkgs, home-manager, user, system, ... }:
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
