{ pkgs, ... }:
{
    programs.waybar = {
        enable = true;
        settings = {
            primary = {
            mode = "dock";
            height = 30;
            margin = "6";
            spacing = 5;
            modules-left = [
              "custom/menu" 
              "wlr/workspaces"];
            modules-center = [
                "clock"
                ];
            modules-right = [
                "cpu"
                "memory"
                "network"
                "pulseaudio"
                "battery"
                "tray"
                "custom/exit"
                "custom/hostname"
                ];
            "wlr/workspaces" = {
                "format" = "{icon}";
                "on-click" = "activate";
                "format-icons"= {
                    "1" = "";
                    "2" = "";
                    "3" = "";
                    "4" = "";
                    "5" = "";
                    "urgent" = "";
                    "active" = "";
                    "default" = "";
                };
            };
            "clock" = {
                "format" = "<span> </span>{:%m/%d %H:%M}";
                "tooltip-format" = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
                "on-click" = "calendar";
            };
            "cpu"= {
                "interval" = 10;
                "format" = " {}%";
                "max-length" = 10;
                "on-click" = "";
                };
            "memory" = {
                "interval" = 30;
                "format" = " {}%";
                "format-alt" = " {used:0.1f}G";
                "max-length" = 10;
            };

            "network" = {
                "format-wifi" = "  {signalStrength}%";
                "format-ethernet" = "  wired";
                "format-disconnected" = "";
                "on-click" = "bash ~/.config/waybar/scripts/rofi-wifi-menu.sh";
            };

            "battery" = {
                "bat" = "BAT0";
                "adapter" = "ADP0";
                "interval" = 60;
                "states" = {
                    "warning" = 30;
                    "critical" = 15;
                };
                "max-length" = 20;
                "format" = "{icon} {capacity}%";
                "format-warning" = "{icon} {capacity}%";
                "format-critical" = "{icon} {capacity}%";
                "format-charging" = "<span font-family='Font Awesome 6 Free'></span> {capacity}%";
                "format-plugged" = "  {capacity}%";
                "format-alt" = "{icon} {time}";
                "format-full" = "  {capacity}%";
                "format-icons" = [" " " " " " " " " "];
                };
            
            "tray" = {
                "spacing" = 10;
            };

            "custom/menu" = {
              "format" = "";
              "on-click" = "rofi -show drun";
            };

            "custom/hostname" = {
              "exec" = "echo $USER@$(hostname)";
              "on-click" = "alacritty";
            };

            "custom/exit" = {
              "format" = "";
              "on-click" = "wlogout";
            };

            "pulseaudio" = {
                "format" = "{icon}  {volume}%";
                "format-muted" = "   0%";
                "format-icons" = {
                  "headphone" = "";
                  "headset" = "";
                  "portable" = "";
                  "default" = [ "" "" "" ];
                };
                "on-click" = "pavucontrol";
              };

        };
    };

        style = ''
        * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 12pt;
        padding: 0 8px;
      }
      .modules-right {
        margin-right: -15px;
      }
      .modules-left {
        margin-left: -15px;
      }
      window#waybar {
        color: #d1ab00;
        background-color: #055C1C;
        opacity: 0.95;
        padding: 0;
        border-radius: 10px;
      }
      window#waybar.bottom {
        opacity: 0.90;
        background-color: #002635;
        border: 2px solid #14747e;
        border-radius: 10px;
      }
   
      #workspaces button {
        padding: 0 5px;
        color: #7984A4;
        background-color: transparent;
        box-shadow: inset 0 -3px transparent;
        border: none;
        border-radius: 0;
      }
      #workspaces button.hidden {
        background-color: #002635;
        color: #869696;
      }
      #workspaces button.focused {
        color: #bf616a;
        }

        #workspaces button.active {
        color: #6a92d7;
        }

        #workspaces button.urgent {
        background-color: #eb4d4b;
        }
      
      #clock {
        padding-left: 15px;
        padding-right: 15px;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }

      #tray {
        color: #a1a19a;
      }

      #custom-hostname {
        background-color: #022c0d;
        color: #d1ab00;
        padding-left: 15px;
        padding-right: 18px;
        margin-right: 0;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }


      #custom-menu {
        font-size: 16pt;
        background-color: #d1ab00;
        color: #002635;
        padding-left: 15px;
        padding-right: 22px;
        margin-left: 0;
        margin-right: 10px;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
        }

      '';
    };
}


