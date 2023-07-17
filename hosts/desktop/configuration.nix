
{ pkgs, ... }:

{
    # Put any specific host configurations here
    boot.initrd.kernelModules = [ "amdgpu" ];
}

