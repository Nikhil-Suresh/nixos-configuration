{ config, pkgs, ... }:
{
  services.displayManager.sddm = {
  enable = true;
  theme = "${import ../../modules/sddm-theme/sddm-theme.nix {inherit pkgs; }}";
  };
}

