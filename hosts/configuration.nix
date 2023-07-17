{ config, pkgs, ... }:

{
    imports = [
        ./programs.nix
    ];
    ### Boot Options ####

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel

    ### Nix Options ###

    nix = {
        package = pkgs.nixFlakes;
        extraOptions = "experimental-features = nix-command flakes";

        settings.auto-optimise-store = true;
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    ### Networking ###

    networking.hostName = pkgs.lib.mkDefault "nixos-device"; # Replace this inside the host specific options
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    networking.networkmanager.wifi.powersave = false;

    ### Sound ###

    sound.enable = true;
    services.pipewire = {
        enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
    };
    hardware.bluetooth.enable = true;

    ### Security ###

    security.polkit.enable = true;
    security.pam.services.gtklock = {}; # Need for gtklock to work

    ### Misc ###

    services.udisks2.enable = true; # USB mounting
    time.timeZone = "Australia/Brisbane";
    services.xserver.layout = "au";

    # Important immutable value: https://nixos.org/nixos/options.html
    system.stateVersion = "23.05";
}
