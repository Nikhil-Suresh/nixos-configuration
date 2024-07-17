{ config, pkgs, ... }:
{
  services.displayManager.sddm = {
  enable = true;
  theme = "Maldives";
  };
}

