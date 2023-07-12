# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }@inputs:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # This is needed for the Nitro Acer 5 laptop to fix issue with network card
    boot.kernelModules = [ "iwlwifi" ];
    boot.kernelParams = [ "iwlwifi.11n_disable=1" "iwlwifi.swcrypto=1" ];

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

    networking.hostName = "bryley-laptop"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    networking.networkmanager.wifi.powersave = false;


    time.timeZone = "Australia/Brisbane";

    programs.git.enable = true;
    programs.git.config = {
        user.name = "Bryley Hayter";
        user.email = "bryleyhayter@gmail.com";
    };

    programs.hyprland = {
        enable = true;
        nvidiaPatches = true;
    };

    # xdg.portal = { # Required for flatpak with window managers and for file browsing
    #     enable = true;
    #     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # };

    programs.zsh.enable = true;

    programs.steam.enable = true;

    # Configure keymap in X11
    services.xserver.layout = "au";

    # Enable sound.
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

    # Enable touchpad support
    services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bryley = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
            shell = pkgs.zsh;
    };

    # List packages installed in system profile. To search, run:
    environment.systemPackages = with pkgs; [
        neovim
        gcc         # C++ Compiler used by Neovim Treesitter
        kitty       # Terminal Emulator

        gtklock     # Screen locking software
        swww        # Wallpaper manager
        waybar      # The bar at the bottom of the screen

        exa         # Alternative to 'ls'
        tmux        # Terminal Multiplexer
        ncdu        # NCursers Disk Usage (TUI for disk usage)
        fzf         # Fuzzy finder software (Used for 'f' and 'ff' alias)
        fd          # Better alternative to 'find' command
        ripgrep     # Better alternative to 'grep' (Used by neovim)
        bat         # Better alternative to 'cat'

        neofetch    # Display's system information
        evince      # PDF viewer

        # Language servers
        nil         # Nix language server

        yt-dlp      # Youtube downloader
        android-file-transfer # For uploading files to my android device

        rofi        # Application searcher

        wl-clipboard # To get clipboard working on hyprland
    ];

    fonts.fonts = with pkgs; [
        inter
        (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; })
    ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

    nixpkgs.overlays = [    # Waybar with experimental features
        (final: prev: {
         waybar = inputs.hyprland.packages.x86_64-linux.waybar-hyprland;
         })
    ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?

}

