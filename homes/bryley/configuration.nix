{ pkgs, ... }:

{
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.bryley = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
        shell = pkgs.zsh;
    };

    programs.git.config = {
        user.name = "Bryley Hayter";
        user.email = "bryleyhayter@gmail.com";
    };
}
