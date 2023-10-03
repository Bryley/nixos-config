{ pkgs }:

let
  desktopItem = pkgs.makeDesktopItem {
    name = "Modrinth";
    exec = "modrinth-app";
    icon = "modrinth";
    desktopName = "Modrinth";
    genericName = "Minecraft Launcher";
    categories = ["Game"];
  };
in pkgs.stdenv.mkDerivation rec {
  pname = "Modrinth";
  version = "0.5.4";

  src = pkgs.fetchurl {
    url = "https://launcher-files.modrinth.com/versions/${version}/linux/modrinth-app_${version}_amd64.deb";
    sha256 = "sha256-CW6RQ89LlKbSq6lL1CWQmO0PmbSl7NtUiX3rrn/6U10=";
  };

  # nativeBuildInputs = [ pkgs.patchelf ];
  nativeBuildInputs = [ pkgs.autoPatchelfHook ];  # add autoPatchelfHook here

  # buildInputs = [ pkgs.dpkg pkgs.xz ];
  buildInputs = with pkgs; [
    dpkg
    # xz                      # for liblzma.so.5
    webkitgtk               # for libwebkit2gtk-4.0.so.37
    gtk3                    # for libgtk-3.so.0 and libgdk-3.so.0
    cairo                   # for libcairo.so.2
    gdk-pixbuf              # for libgdk_pixbuf-2.0.so.0
    libsoup                 # for libsoup-2.4.so.1
    glib                    # for libgio-2.0.so.0, libgobject-2.0.so.0, libglib-2.0.so.0
    openssl                 # for libssl.so.1.1 and libcrypto.so.1.1
  ];


  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/applications
    cp -r usr/* $out/
    # Patch the binary to use Nix's glibc
    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/bin/modrinth-app

    ln -s ${desktopItem}/share/applications/* $out/share/applications
  '';

  meta = with pkgs.lib; {
    description = "Modrinth Minecraft Launcher";
    homepage = "https://modrinth.com";
    license = licenses.mit; # Adjust the license accordingly
    platforms = platforms.linux;
  };
}

