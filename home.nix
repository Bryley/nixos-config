# TODO this file should be deleted
{ pkgs, ... }:

{

    home.username = "bryley";
    home.homeDirectory = "/home/bryley";
    home.packages = with pkgs; [
        brave
    ];
    programs.home-manager.enable = true;

    gtk = {
        enable = true;
        # theme = {
        #     name = "Catppuccin-Macchiato-Compact-Pink-dark";
        #     package = pkgs.catppuccin-gtk.override {
        #         accents = [ "pink" ];
        #         size = "compact";
        #         tweaks = [ "rimless" "black" ];
        #         variant = "macchiato";
        #     };
        # };
    };

    home.file.".config/hypr" = {
        source = ./configs/hypr;
        recursive = true;
    };

    home.file.".config/waybar" = {
        source = ./configs/waybar;
        recursive = true;
    };

    home.file.".config/gtklock" = {
        source = ./configs/gtklock;
        recursive = true;
    };

    home.file.".config/nvim" = {
        source = ./configs/nvim;
        recursive = true;
    };

    home.file.".config/zsh" = {
        source = ./configs/zsh;
        recursive = true;
    };
    home.file.".zshenv" = {
        source = ./configs/.zshenv;
    };

    home.file.".config/kitty" = {
        source = ./configs/kitty;
        recursive = true;
    };

    home.file.".config/tmux" = {
        source = ./configs/tmux;
        recursive = true;
    };

    home.file."bin" = {
        source = ./bin;
        recursive = true;
    };

    home.stateVersion = "23.05";
}
