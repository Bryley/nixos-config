{
    description = "Bryley's NixOS Configuration";

# TODO's
# - [ ] Better Hyprland
# - [X] Nerd Fonts across system
# - [X] Waybar
#   - [X] Fix middle thing that has desktops on it and autostarts
# - [ ] Nvidia drivers and stuff
# - [ ] ZSH change fast theme to base-16 automatically
# - [ ] LSP servers Nvim
# - [X] Garbage Collection of nix system
# - [X] Wallpaper
# - [X] Sound
# - [X] GTKLock
# - [X] Redshift
# - [ ] Multiple Configs
# - [ ] Convert some configs to Home-Manager
# - [ ] Turn into git repo


# Organisation:
# flake.nix
# flake.lock
# hosts:
#   default.nix
#   configuration.nix
#   programs:
#       default.nix
#       
#   laptop:
#       hardware-configuration.nix
#       configuration.nix
#
# homes:
#   bryley:
#       default.nix

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, hyprland }:
    {
        nixosConfigurations = import ./hosts {
            inherit nixpkgs home-manager hyprland;
        };
    };

    # let
    #     system = "x86_64-linux";
    #     pkgs = import nixpkgs {
    #         inherit system;
    #         config.allowUnfree = true;
    #     };
    #     lib = nixpkgs.lib;
    # in {
    #     nixosConfigurations = {
    #         laptop = lib.nixosSystem {
    #             inherit system pkgs;
    #             modules = [
    #                 hyprland.nixosModules.default
    #                 ./configuration.nix
    #                 home-manager.nixosModules.home-manager {
    #                     home-manager.useGlobalPkgs = true;
    #                     home-manager.useUserPackages = true;
    #                     home-manager.users.bryley = {
    #                         imports = [ ./home.nix ];
    #                     };
    #                 }
    #             ];
    #         };
    #     };
    # };

}
