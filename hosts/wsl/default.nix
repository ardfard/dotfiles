{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  imports = [
    # "${modulesPath}/profiles/minimal.nix"

    nixos-wsl.nixosModules.wsl
  ];


  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "ardfard";
    startMenuLaunchers = true;

    # Enable native Docker support
    docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;

  };


}
