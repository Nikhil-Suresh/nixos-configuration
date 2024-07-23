{ config, pkgs, inputs, ... }:

{ imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./sddm.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "runesmith"; # Define your hostname.

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "au";
    xkb.variant = "";
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Hyprland as an option in SDDM.
  programs.hyprland.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = { LC_ADDRESS = "en_AU.UTF-8"; LC_IDENTIFICATION = "en_AU.UTF-8"; LC_MEASUREMENT = "en_AU.UTF-8"; LC_MONETARY = "en_AU.UTF-8"; LC_NAME = "en_AU.UTF-8"; LC_NUMERIC = "en_AU.UTF-8"; LC_PAPER = 
    "en_AU.UTF-8"; LC_TELEPHONE = "en_AU.UTF-8"; LC_TIME = "en_AU.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nik = { isNormalUser = true; description = "Nikhil Suresh"; extraGroups = [ "networkmanager" "wheel" "gamemode" ]; packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nik" = import ./home.nix;
    };
    useGlobalPkgs = true;
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);
 
  # Graphics. 
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };
  
  hardware.nvidia = {
  modesetting.enable = true;
  nvidiaSettings = true;
  };
  
  # Gaming
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    home-manager
    libnotify
    libsForQt5.qt5.qtgraphicaleffects
    mako
    networkmanagerapplet
    protonup
    rofi-wayland
    swww
    vim 
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
     })
    )
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # It‘s perfectly fine and recommended to leave this value at the 
  # release version of the first install of this system. Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  
  # Required for electron apps.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Enables audio.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable the SSH agent on every startup.
  programs.ssh.startAgent = true;

  # Enable printing.
  services.printing.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable stylix.
    stylix.base16Scheme = {
    base00 = "3c3836";
    base01 = "3c3836";
    base02 = "3c3836";
    base03 = "665c54";
    base04 = "bdae93";
    base05 = "d5c4a1";
    base06 = "ebdbb2";
    base07 = "fbf1c7";
    base08 = "fb4934";
    base09 = "fe8019";
    base0A = "fabd2f";
    base0B = "d65d0e";
    base0C = "8ec07c";
    base0D = "83a598";
    base0E = "d3869b";
    base0F = "d65d0e";
  };
  
  # Don't forget to apply wallpaper
  
  stylix.image = ../../modules/home-manager/wallpaper.jpg;
  stylix.enable = true;
  stylix.opacity.terminal = 0.8;
}
