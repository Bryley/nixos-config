{ pkgs }:
let
  desktopItem = pkgs.makeDesktopItem {
    name = "GDLauncher";
    exec = "GDLauncher";
    icon = "gdlauncher";
    desktopName = "GDLauncher";
    genericName = "Minecraft Launcher";
    categories = ["Game"];
  };
in pkgs.appimageTools.wrapType2 {
  name = "GDLauncher";
  src = pkgs.fetchurl {
    url =
      "https://github.com/gorilla-devs/GDLauncher/releases/latest/download/GDLauncher-linux-setup.AppImage";
    hash = "sha256-4cXT3exhoMAK6gW3Cpx1L7cm9Xm0FK912gGcRyLYPwM=";
  };
  extraPkgs = pkgs: with pkgs; [ ];
  extraInstallCommands = ''
    mkdir -p $out/share/applications
    ln -s ${desktopItem}/share/applications/* $out/share/applications
  '';
}
