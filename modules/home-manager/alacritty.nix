{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window.padding = {
        x = 24;
        y = 24;
      };
      window.decorations = "none";
      window.opacity = 0.7;
      scrolling.history = 1000;
      font = {
        normal = {
          family = "Terminess Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "Terminess Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "Terminess Nerd Font Mono";
          style = "Italic";
        };
        size = 18;
      };
      shell.program = "fish";
    };
  };
}
