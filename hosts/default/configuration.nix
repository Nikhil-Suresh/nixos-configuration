# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{ imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./sddm.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary networking.proxy.default = "http://user:password@proxy:port/"; networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  # Set hyprland as my desktop environment.
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
  };
  programs.sway.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = { LC_ADDRESS = "en_AU.UTF-8"; LC_IDENTIFICATION = "en_AU.UTF-8"; LC_MEASUREMENT = "en_AU.UTF-8"; LC_MONETARY = "en_AU.UTF-8"; LC_NAME = "en_AU.UTF-8"; LC_NUMERIC = "en_AU.UTF-8"; LC_PAPER = 
    "en_AU.UTF-8"; LC_TELEPHONE = "en_AU.UTF-8"; LC_TIME = "en_AU.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nik = { isNormalUser = true; description = "Nikhil Suresh"; extraGroups = [ "networkmanager" "wheel" ]; packages = with pkgs; [];
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
    mako
    networkmanagerapplet
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

  # Some programs need SUID wrappers, can be configured further or are started in user sessions. programs.mtr.enable = true; programs.gnupg.agent = {
  #   enable = true; enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon. services.openssh.enable = true;

  # Open ports in the firewall. networking.firewall.allowedTCPPorts = [ ... ]; networking.firewall.allowedUDPPorts = [ ... ]; Or disable the firewall altogether. networking.firewall.enable = false;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken. It‘s perfectly fine and recommended to leave this value at the 
  # release version of the first install of this system. Before changing this value read the documentation for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable printing.
  services.printing.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;
}
