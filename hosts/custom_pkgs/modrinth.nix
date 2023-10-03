
{ pkgs ? import <nixpkgs> {} }:

let
  appName = "modrinth-app";
  version = "0.5.4";
  appImage = pkgs.fetchurl {
    url =
      "https://launcher-files.modrinth.com/versions/0.5.4/linux/modrinth-app_0.5.4_amd64.AppImage";
    hash = "sha256-XEdajR+Fxjk1myLSNwLFPgFBcYTu1bXOy/oUjSAg0sE=";
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "${appName}-appimage-run";
  inherit version;

  src = appImage;

  buildInputs = [ pkgs.libthai pkgs.appimage-run ];

   buildCommand = ''
    mkdir -p $out/bin
    cat > $out/bin/run-${appName} <<EOF
    #!/bin/sh
    export LD_LIBRARY_PATH=${pkgs.libthai}/lib:\$LD_LIBRARY_PATH
    exec ${pkgs.appimage-run}/bin/appimage-run $src "\$@"
    EOF
    chmod +x $out/bin/run-${appName}
  '';

  # buildCommand = ''
  #   mkdir -p $out/bin
  #   cat > $out/bin/run-${appName} <<EOF
  #   #!/bin/sh
  #   exec ${pkgs.appimage-run}/bin/appimage-run $src "\$@"
  #   EOF
  #   chmod +x $out/bin/run-${appName}
  # '';

  meta = with pkgs.lib; {
    description = "Wrapper for running ${appName} AppImage";
    homepage = "https://modrinth.com";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
