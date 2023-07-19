{ pkgs, ... }:

{

    programs.git.enable = true;
    programs.hyprland = {
        enable = true;
        nvidiaPatches = true;
    };
    programs.waybar = {
        enable = true;
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
           mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
    };
    services.blueman.enable = true;
    programs.zsh.enable = true;
    programs.steam.enable = true;

    # Command not found alternative for flakes
    programs.command-not-found.enable = true;
    # programs.nix-index = {
    #     enable = true;
    #     enableZshIntegration = true;
    # };

    environment.systemPackages = with pkgs; [

        # Essential CMD Line Tools #

        tmux        # Terminal Multiplexer
        exa         # Alternative to 'ls'
        ncdu        # NCursers Disk Usage (TUI for disk usage)
        fzf         # Fuzzy finder software (Used for 'f' and 'ff' alias)
        fd          # Better alternative to 'find' command
        ripgrep     # Better alternative to 'grep' (Used by neovim)
        bat         # Better alternative to 'cat'
        yt-dlp      # Youtube downloader
        neofetch    # Display's system information
        evince      # PDF viewer
        zip         # Zipping application
        unzip       # Unzipping application

        # Neovim #

        neovim      # Terminal based Text Editor
        gcc         # C++ Compiler used by Neovim Treesitter
        # Language servers
        nil         # Nix language server
        lua-language-server # Language server for lua
        nodePackages.pyright # Python language server
        ltex-ls     # Latex and markdown Language server

        # GUI Applications #

        kitty       # Terminal Emulator
        gtklock     # Screen locking software
        swww        # Wallpaper manager
        rofi-wayland # Application searcher
        wl-clipboard # To get clipboard working on hyprland
        android-file-transfer # For uploading files to my android device
        gammastep   # Bluelight reducing application
        cinnamon.nemo-with-extensions # File manager
        udiskie     # USB manager
        dunst       # Notification manager
        polkit_gnome # Authentication Agent
        pavucontrol # Audio control
        audacity    # Audio editor
        obs-studio  # Recording software
        obsidian    # Markdown editor
        vlc         # Audio and video player

        prismlauncher # Minecraft Launcher
    ];

    fonts.fonts = with pkgs; [
        inter
        (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; })
    ];

}
