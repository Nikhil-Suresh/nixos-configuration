{
  # Import all your configuration modules here
  imports = [ ./bufferline.nix ];

  colorschemes.gruvbox.enable = true;

  plugins = {
    lualine.enable = true;
    airline.enable = true;
  };
}
