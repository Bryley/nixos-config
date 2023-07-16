#!/bin/sh


DEFAULT_NIX_TEMPLATE="
{ pkgs, ... }:

{
    imports = [
        ../configuration.nix
        ./configuration.nix
        ./hardware-configuration.nix
    ];
}
"

CONF_NIX_TEMPLATE="
{ pkgs, ... }:

{
    # Put any specific host configurations here
}
"

genhost() {
    HOSTNAME=$1

    mkdir ./hosts/$HOSTNAME &> /dev/null

    if [ $? -ne 0 ]; then
        echo "Invalid hostname"
        return;
    fi
    
    HOSTDIR="./hosts/$HOSTNAME"

    echo "$DEFAULT_NIX_TEMPLATE" > $HOSTDIR/default.nix
    echo "Generated '$HOSTDIR/default.nix'"
    echo "$CONF_NIX_TEMPLATE" > $HOSTDIR/configuration.nix
    echo "Generated '$HOSTDIR/configuration.nix'"
    nixos-generate-config --root /mnt --show-hardware-config > $HOSTDIR/hardware-configuration.nix
    echo "Generated '$HOSTDIR/hardware-configuration.nix'"

    echo "All done, make sure to edit ./hosts/default.nix to add '$HOSTNAME' to the list."
}

genhost $1
