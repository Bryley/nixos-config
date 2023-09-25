{ pkgs, ... }:
let
  customNodePkgs = pkgs.callPackage ./node_pkgs {  };
in {

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

    # Enable docker
    virtualisation.docker.enable = true;

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
        poppler_utils # PDF Utils
        python3Full # Python
        nodejs_20   # Node and NPM
        rustup      # Rust toolchain application
        docker-compose # Add docker-compose command
        nushell     # Rust shell with cool features (like http command)
        pkg-config  # Tool to find out information about other packages
        # dioxus-cli  # Cli tool for dioxus applications
        # wasm-bindgen-cli # wasm tool for rust
        # openssl     # OpenSSL 
        openjdk     # Java Developer Kit
        android-studio  # Android IDE (Also sets everything up for me)
        gradle      # Build tool for Java/Kotlin Applications
        kotlin      # Kotlin Compiler
        bun         # Fast Javascript Runtime
        node2nix    # Tool for getting npm packages on nix
        just        # A more modern alternative to make, a basic build tool
        customNodePkgs."@ionic/cli"
        customNodePkgs."nativescript" # Nativescript cli tool
        flutter   # Flutter Crossplatform app dev
        xdg-utils   # Adds some xdg-open commands and stuff

        # Neovim #

        neovim      # Terminal based Text Editor
        gcc         # C++ Compiler used by Neovim Treesitter
        # Language servers
        # nil         # Nix language server
        nixd        # Nix language server
        lua-language-server # Language server for lua
        nodePackages.pyright # Python language server
        nodePackages.svelte-language-server # Svelte language server
        nodePackages.dockerfile-language-server-nodejs # Docker language server
        # nodePackages.vscode-json-languageserver # JSON language server
        nodePackages.yaml-language-server # Yaml language server
        customNodePkgs."@vtsls/language-server" # Typescript language server
        customNodePkgs."vscode-json-languageservice" # JSON Language server
        kotlin-language-server  # Kotlin Language Server
        nodePackages.prettier # Typescript formatter
        ltex-ls     # Latex and markdown Language server
        black       # Python formatter
        nixfmt      # Nix formatter

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
        (audacity.overrideAttrs (oldAttrs: {
            postInstall = oldAttrs.postInstall or "" + ''
                wrapProgram $out/bin/audacity --set GDK_BACKEND x11
            '';
        })) # Audio editor
        obs-studio  # Recording software
        obsidian    # Markdown editor
        vlc         # Audio and video player
        libreoffice # Microsoft Office Alternative
        dbeaver     # DB UI Software
        postman     # Restful API client

        prismlauncher # Minecraft Launcher
    ];

    fonts.fonts = with pkgs; [
        inter
        (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; })
    ];

}
