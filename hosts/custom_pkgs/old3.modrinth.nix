{ pkgs }:

let
  # desktopItem = pkgs.makeDesktopItem {
  #   name = "Modrinth";
  #   exec = "modrinth-app";
  #   icon = "modrinth";
  #   desktopName = "Modrinth";
  #   genericName = "Minecraft Launcher";
  #   categories = ["Game"];
  # };

  debEnv = pkgs.buildEnv {
    name = "debEnv";
    paths = [ pkgs.dpkg ];
  };

in pkgs.buildFHSUserEnv {
  name = "Modrinth";
  targetPkgs = pkgs: with pkgs; [
    xz
    webkitgtk
    gtk3
    cairo
    gdk-pixbuf
    libsoup
    glib
    openssl
  ];

  multiPkgs = null;

  runScript = "modrinth-app";

  profile = ''
    export PATH=/usr/bin
  '';

  extraBuildCommands = ''
    # Unpack the .deb file to the chroot environment
    ${debEnv}/bin/dpkg-deb -x ${pkgs.fetchurl {
      url = "https://launcher-files.modrinth.com/versions/0.5.4/linux/modrinth-app_0.5.4_amd64.deb";
      sha256 = "sha256-CW6RQ89LlKbSq6lL1CWQmO0PmbSl7NtUiX3rrn/6U10=";
    }} $out/usr

    # Link the desktop item to the chroot environment
    # mkdir -p $out/usr/share/applications
  '';
}

    # ln -s ${desktopItem}/share/applications/* $out/usr/share/applications
