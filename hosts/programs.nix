{ pkgs, ... }:

{

    programs.git.enable = true;
    programs.hyprland = {
        enable = true;
        nvidiaPatches = true;
    };
    programs.zsh.enable = true;
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [

        # Essential CMD Line Tools #

        tmux        # Terminal Multiplexer
        exa         # Alternative to 'ls'
        ncdu        # NCursers Disk Usage (TUI for disk usage)
        fzf         # Fuzzy finder software (Used for 'f' and 'ff' alias) fd          # Better alternative to 'find' command
        ripgrep     # Better alternative to 'grep' (Used by neovim)
        bat         # Better alternative to 'cat'
        yt-dlp      # Youtube downloader
        neofetch    # Display's system information
        evince      # PDF viewer

        # Neovim #

        neovim      # Terminal based Text Editor
        gcc         # C++ Compiler used by Neovim Treesitter
        # Language servers
        nil         # Nix language server

        # GUI Applications #

        kitty       # Terminal Emulator
        gtklock     # Screen locking software
        swww        # Wallpaper manager
        waybar      # The bar at the bottom of the screen
        rofi        # Application searcher
        wl-clipboard # To get clipboard working on hyprland
        android-file-transfer # For uploading files to my android device
    ];

    fonts.fonts = with pkgs; [
        inter
        (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; })
    ];
}
