{ pkgs, ... }:

{
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bryley = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "davfs2" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.
        shell = pkgs.zsh;
    };

    programs.git.config = {
        user.name = "Bryley Hayter";
        user.email = "bryleyhayter@gmail.com";
    };

    services.davfs2.enable = true;
    # services.autofs = {
    #   enable = true;
    #   autoMaster = let
    #     mapConf = pkgs.writeText "auto" ''
    #       nextcloud -fstype=davfs,conf=/etc/davfs2/davfs2.conf,uid=1000 :https\:hayman.click/remote.php/webdav/
    #     '';
    #   in ''
    #     /home/bryley/mounts file:${mapConf}
    #   '';
    # };

}
