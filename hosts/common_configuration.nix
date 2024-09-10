{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./sddm.nix
    inputs.home-manager.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "runesmith"; # Define your hostname.

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "au";
    xkb.variant = "";
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };
  services.displayManager.defaultSession = "xfce+i3";
  services.picom.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nik = {
    isNormalUser = true;
    description = "Nikhil Suresh";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
    packages = with pkgs; [ ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
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

  # Help with non-Nix binaries for Neovim.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    lua-language-server
    ruff
  ];

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    bitwarden-cli
    bitwarden-desktop
    cachix
    cargo
    clang
    discord
    dolphin
    dunst
    feh
    firefox
    fish
    flameshot
    git
    go
    google-chrome
    home-manager
    jump
    keymapp
    libreoffice-still
    libnotify
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.breeze-icons
    libsForQt5.konsole
    lua
    mako
    networkmanagerapplet
    nodejs_22
    pavucontrol
    pinta
    polybarFull
    protonup
    python3
    qutebrowser
    ripgrep
    rofi-wayland
    slack
    spotify
    swww
    unzip
    via
    vim
    vscode
    winetricks
    xclip
    xsel
  ];

  fonts.packages = with pkgs; [ terminus-nerdfont font-awesome ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

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

  # Try a different DNS thingo.
  services.resolved.enable = true;

  # Flatpak.
  services.flatpak.enable = true;
}