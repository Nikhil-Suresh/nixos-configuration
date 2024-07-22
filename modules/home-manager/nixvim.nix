{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.tokyonight.enable = true;

    plugins.airline.enable = true;
    plugins.fugitive.enable = true;
    plugins.harpoon.enable = true;

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        pyright.enable = true;
	elixirls.enable = true;
	nixd.enable = true;
      };
    };
    plugins.lsp-lines.enable = true;
    plugins.lsp-format.enable = true;

    plugins.cmp.enable = true;
    };
}
