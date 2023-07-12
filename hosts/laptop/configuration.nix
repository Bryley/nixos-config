{ pkgs, ... }:

{
    # This is needed for the Nitro Acer 5 laptop to fix issue with network card
    boot.kernelModules = [ "iwlwifi" ];
    boot.kernelParams = [ "iwlwifi.11n_disable=1" "iwlwifi.swcrypto=1" ];

    networking.hostName = "bryley-laptop";

    services.xserver.libinput.enable = true; # Touchpad support
}
