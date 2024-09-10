This repository contains my NixOS configurations for my desktop and laptop, some details on the steps that I still run imperatively, and notes on how to set up a new machine to work with these.

# Setup instructions

1. Install NixOS on a machine
1. Clone this repository
1. Build NixOS from these configurations

The `flake.nix` has setups for my desktop and laptop that can be modified for your own purposes.

For example, to create a setup that mimics my desktop, run:

`sudo nixos-rebuild switch --flake ~/nixos-configuration/#runesmith`
