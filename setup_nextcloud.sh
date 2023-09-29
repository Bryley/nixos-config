#/bin/sh

mkdir -p ~/.davfs2 && \
echo "https://hayman.click/remote.php/dav/files/bryley/ /home/bryley/nextcloud bryley \"REPLACE ME WITH PASSWORD\"" > ~/.davfs2/secrets && \
sudo chmod 0600 ~/.davfs2/secrets


# Ensure the mount point exists
mkdir -p $HOME/nextcloud

# Mount the Nextcloud WebDAV
if ! mountpoint -q $HOME/nextcloud; then
    mount -t davfs https://hayman.click/remote.php/dav/files/bryley/ $HOME/nextcloud
fi

