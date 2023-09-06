
# Bryley's NixOS Config

## Setting Up

### Network

You will need internet for the setup. Ethernet should already be connected if
using that otherwise you need to use `wpa_supplicant` for wifi:

1. Start Wifi service
```
sudo systemctl start wpa_supplicant
```
TODO more instructions

### Partitioning

Now you need to partition your disks correctly.

First identify the disk you want to partition using `lsblk`:

You will see something like this:

```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0         7:0    0 778.1M  1 loop /nix/.ro-store
sda           8:0    1   3.6G  0 disk
...
nvme0n1     259:0    0 476.9G  0 disk 
...
```

You can see that `nvme0n1` is the main disk that you will need to partition.

For NixOS you will need a:

1. Boot partition:
    Contains information on how to boot into your system.
2. Root partition:
    Contains all your files on your system.
3. Swap
    Space on the end that acts as space to backup your RAM if it ever gets too
    full.

```
+--------------------------------------------------+
|####|##################################|##########|
|Boot| File System                      | Swap 8GB |
+--------------------------------------------------+
```

```
sudo parted /dev/nvme0n1
> mklabel gpt                           # Creates new disklabel of gpt format
> mkpart primary 512MB -8GB             # Creates the "root" partition.
> mkpart primary linux-swap -8GB 100%   # Make the swap partition
> mkpart ESP fat32 1MB 512MB            # Make the "boot" partition
> set 3 esp on                          # Enables boot for partition 3
> print                                 # Optional, just to print out partitions
> quit
```

### Formatting

How that we have the partitions setup, next you need to format the partitions.

- Boot must be an FAT32 partition.
- Root should be a ext4 partition
- Swap must be a special swap partition

```
sudo mkfs.ext4 -L nixos /dev/nvme0n1p1      # Set root partition (called nixos)
sudo mkswap -L swap /dev/nvme0n1p2          # Set swap
sudo mkfs.fat -F 32 -n boot /dev/nvme0n1p3  # Set boot partition (called boot)
```

Now all the partitions should be setup

### Installing

```
sudo mount /dev/disk/by-label/nixos /mnt     # Everything in /mnt will be in actual OS
sudo mkdir -p /mnt/boot                      # Make boot folder
sudo mount /dev/disk/by-label/boot /mnt/boot # mount boot partition to it
sudo swapon /dev/disk/by-label/swap          # Enable swap
cd /mnt
```

Now you want to install git so you can clone the repo:

```
sudo -i             # Switch to root user as you will need it from now on.
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git
```

Now you will have git until you type "exit"

```
git clone https://github.com/Bryley/nixos-config.git /mnt/nixos/nixos-config
```

Now if you are using a new host computer that has not had NixOS setup on it
before make sure to run `./newhost.sh`, this will generate a new host with a
fresh `hardware-configuration.nix` in the appropriate location.

You will also need to add the following to the return value in
`./hosts/default.nix`:

```nix
    [ HOST NAME HERE ] = lib.nixosSystem rec{
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
        modules = [
            hyprland.nixosModules.default
            ./[ HOST NAME HERE ]
            ../homes/${user}/configuration.nix
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user} = {
                    imports = [ ../homes/${user}/home.nix ];
                };
            }
        ];
    };

```

After that now you can install your system by running `nixos-install --flake .#<host>`.

This should install and setup the entire system.


## Notes

Cool Wallpaper: https://unsplash.com/photos/4hluhoRJokI

Add davfs2/secrets file:

```bash
mkdir -p ~/.davfs2 && echo "https://hayman.click/remote.php/dav/files/bryley/ /home/bryley/nextcloud bryley \"REPLACE ME WITH PASSWORD\"" > ~/.davfs2/secrets && sudo chmod 0600 ~/.davfs2/secrets
```
