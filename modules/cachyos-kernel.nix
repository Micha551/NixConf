{ pkgs, nix-cachyos-kernel, lib, ... }:

{
  nixpkgs.overlays = [
    nix-cachyos-kernel.overlays.default
  ];

  boot.kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
}
