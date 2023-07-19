
{ pkgs, ... }:

{
    imports = [
        ../configuration.nix
        ./configuration.nix
        ./hardware-configuration.nix
    ];
}

