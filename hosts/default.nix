{ nixpkgs, home-manager, hyprland, ... }:
let
    user = "bryley";
    lib = nixpkgs.lib;
in {
    laptop = lib.nixosSystem rec{
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        modules = [
            hyprland.nixosModules.default
            ./laptop
            ../homes/${user}/configuration.nix
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} = {
                    imports = [ ../homes/${user}/home.nix ];
                };
            }
        ];
    };
    desktop = lib.nixosSystem rec{
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        modules = [
            hyprland.nixosModules.default
            ./desktop
            ../homes/${user}/configuration.nix
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} = {
                    imports = [ ../homes/${user}/home.nix ];
                };
            }
        ];
    };
}
