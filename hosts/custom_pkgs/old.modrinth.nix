{ pkgs }:
let
  desktopItem = pkgs.makeDesktopItem {
    name = "Modrinth";
    exec = "modrinth";
    icon = "modrinth";
    desktopName = "Modrinth";
    genericName = "Minecraft Launcher";
    categories = ["Game"];
  };
in pkgs.appimageTools.wrapType2 {
  name = "Modrinth";
  src = pkgs.fetchurl {
    url =
      "https://launcher-files.modrinth.com/versions/0.5.4/linux/modrinth-app_0.5.4_amd64.AppImage";
    hash = "sha256-XEdajR+Fxjk1myLSNwLFPgFBcYTu1bXOy/oUjSAg0sE=";
  };
  extraPkgs = pkgs: with pkgs; [ 
    libthai
  ];
  extraInstallCommands = ''
    mkdir -p $out/share/applications
    ln -s ${desktopItem}/share/applications/* $out/share/applications
  '';
}
