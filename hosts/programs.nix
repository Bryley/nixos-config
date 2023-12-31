{ pkgs, ... }:
let
  customNodePkgs = pkgs.callPackage ./node_pkgs { };
  # customJdkVersion = import (fetchTarball {
  #   url =
  #     "https://github.com/NixOS/nixpkgs/archive/c984213d12225fa5feb640136872da56d2e8f702.tar.gz";
  #   sha256 = "sha256:0wrk6i6iqzvnjd6i4p70mq7kxlb1kf9cppm3b49gpll0qixawpqz";
  # }) { };
  oldJava8Version = import (fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/c984213d12225fa5feb640136872da56d2e8f702.tar.gz";
    sha256 = "sha256:0wrk6i6iqzvnjd6i4p70mq7kxlb1kf9cppm3b49gpll0qixawpqz";
  }) { system = "x86_64-linux"; };
  oldGlibcVersion = import (fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/7c035dbb7544ae2a9adc2320e7d84c7b7d9477ed.tar.gz";
    sha256 = "sha256:0f508da3yp0pcm5azgwv8km8nn38rf92wpqmhgr0wkyydfa2syc7";
  }) { system = "x86_64-linux"; };
in {

  # Nix-ld helps with running random executables and library linking
  # programs.nix-ld.enable = true;
  # environment.variables = {
  #   NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
  #     pkgs.stdenv.cc.cc
  #     pkgs.openssl
  #     # add here the libraries you want...
  #   ];
  #   NIX_LD = pkgs.lib.fileContents "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  # };

  programs.git.enable = true;
  programs.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
  };
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
  };
  services.blueman.enable = true;
  programs.zsh.enable = true;
  # programs.steam.enable = true;
  # hardware.opengl.driSupport32Bit = true;

  services.flatpak.enable = true;
  xdg.portal.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # nixpkgs.overlays = [
  #   (final: prev: {
  #     steam = prev.steam.override ({ extraPkgs ? pkgs': [], ... }: {
  #       extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
  #         libgdiplus
  #       ]);
  #     });
  #   })
  # ];

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

    file # The `file` command for analising files
    tmux # Terminal Multiplexer
    eza # Alternative to 'ls'
    ncdu # NCursers Disk Usage (TUI for disk usage)
    fzf # Fuzzy finder software (Used for 'f' and 'ff' alias)
    fd # Better alternative to 'find' command
    ripgrep # Better alternative to 'grep' (Used by neovim)
    bat # Better alternative to 'cat'
    yt-dlp # Youtube downloader
    neofetch # Display's system information
    evince # PDF viewer
    zip # Zipping application
    unzip # Unzipping application
    poppler_utils # PDF Utils
    python3Full # Python
    nodejs_20 # Node and NPM
    rustup # Rust toolchain application
    docker-compose # Add docker-compose command
    nushell # Rust shell with cool features (like http command)
    pkg-config # Tool to find out information about other packages
    # dioxus-cli  # Cli tool for dioxus applications
    # wasm-bindgen-cli # wasm tool for rust
    # openssl     # OpenSSL 
    openjdk # Java Developer Kit
    android-studio # Android IDE (Also sets everything up for me)
    gradle # Build tool for Java/Kotlin Applications
    kotlin # Kotlin Compiler
    bun # Fast Javascript Runtime
    node2nix # Tool for getting npm packages on nix
    just # A more modern alternative to make, a basic build tool
    customNodePkgs."@ionic/cli"
    # customNodePkgs."nativescript" # Nativescript cli tool
    flutter # Flutter Crossplatform app dev
    xdg-utils # Adds some xdg-open commands and stuff
    nodePackages.tailwindcss # Tailwind cli tool
    cargo-generate # Generates templates from rust cargo
    cargo-leptos # Leptos build tool for SSR
    # ollama  # Docker for LLMs
    sass # CLI Tool for SCSS files
    lutris # Game launcher
    distrobox
    # PR: 267722
    (virt-manager.overrideAttrs (old: {
      nativeBuildInputs = old.nativeBuildInputs ++ [ wrapGAppsHook ];
      buildInputs = lib.lists.subtractLists [ wrapGAppsHook ] old.buildInputs
        ++ [ gst_all_1.gst-plugins-base gst_all_1.gst-plugins-good ];
    }))

    # Neovim #

    neovim # Terminal based Text Editor
    gcc # C++ Compiler used by Neovim Treesitter
    # Language servers
    # nil         # Nix language server
    nixd # Nix language server
    lua-language-server # Language server for lua
    nodePackages.pyright # Python language server
    nodePackages.svelte-language-server # Svelte language server
    nodePackages.dockerfile-language-server-nodejs # Docker language server
    # nodePackages.vscode-json-languageserver # JSON language server
    nodePackages.yaml-language-server # Yaml language server
    customNodePkgs."@vtsls/language-server" # Typescript language server
    customNodePkgs."vscode-json-languageservice" # JSON Language server
    kotlin-language-server # Kotlin Language Server
    nodePackages.prettier # Typescript formatter
    ltex-ls # Latex and markdown Language server
    black # Python formatter
    nixfmt # Nix formatter
    rust-analyzer # Rust LSP

    # GUI Applications #

    kitty # Terminal Emulator
    gtklock # Screen locking software
    swww # Wallpaper manager
    rofi-wayland # Application searcher
    wl-clipboard # To get clipboard working on hyprland
    android-file-transfer # For uploading files to my android device
    gammastep # Bluelight reducing application
    cinnamon.nemo-with-extensions # File manager
    udiskie # USB manager
    dunst # Notification manager
    polkit_gnome # Authentication Agent
    pavucontrol # Audio control
    (audacity.overrideAttrs (oldAttrs: {
      postInstall = oldAttrs.postInstall or "" + ''
        wrapProgram $out/bin/audacity --set GDK_BACKEND x11
      '';
    })) # Audio editor
    obs-studio # Recording software
    obsidian # Markdown editor
    vlc # Audio and video player
    gimp # Photo editor

    (python3.withPackages (ps: with ps; [ numpy pandas matplotlib ]))

    libreoffice # Microsoft Office Alternative
    dbeaver # DB UI Software
    # postman # Restful API client

    # (import ./custom_pkgs/gdlauncher.nix { inherit pkgs; }) # Minecraft
    # customJdkVersion.openjdk8
    # (import (fetchTarball {
    #   url =
    #     "https://github.com/NixOS/nixpkgs/archive/c984213d12225fa5feb640136872da56d2e8f702.tar.gz";
    #   sha256 = "sha256:0wrk6i6iqzvnjd6i4p70mq7kxlb1kf9cppm3b49gpll0qixawpqz";
    # }) { system = "x86_64-linux"; }).openjdk8
    oldGlibcVersion.glibc
    oldJava8Version.openjdk8
    prismlauncher # Minecraft Launcher
    (import ./custom_pkgs/ollama.nix {
      inherit (pkgs)
      ;
      lib = pkgs.lib;
      buildGoModule = pkgs.buildGoModule;
      fetchFromGitHub = pkgs.fetchFromGitHub;
      stdenv = pkgs.stdenv;
      darwin = pkgs.darwin;
    }) # Ollama newer version
  ];

  fonts.packages = with pkgs; [
    inter
    (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; })
  ];

}
