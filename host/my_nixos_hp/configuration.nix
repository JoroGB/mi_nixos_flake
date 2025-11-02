{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Grub loader
        boot.loader.systemd-boot.enable = false;
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "nodev";
	boot.loader.grub.useOSProber = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot";
 # nvidia drivers

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # Enable 32-bit graphics support for Steam
  services.xserver.videoDrivers = ["nvidia"];

hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

    networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Costa_Rica";
  time.hardwareClockInLocalTime = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  programs.hyprland = {
    xwayland.enable = true;
    enable = true;
    withUWSM = true;
  };

  services.flatpak.enable = true;
  # Configure keymap in X11
   services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
   # services.xserver = {
   # enable = true;
   # displayManager.gdm.enable = true;
   # desktopManager.gnome.enable = true;
   # };
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
   users.users.joronix = {
     password = "fungy2005";
     isNormalUser = true;
     extraGroups = [ "wheel" "Docker" ]; # Enable 'sudo' for the user.
     packages = with pkgs; [
       tree
       nushell
       neovim
       zellij
     ];
   };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

 # myslq service
   services.mysql = {
   enable = true;
   package = pkgs.mysql84;
#   rootPassword = "";
};


   programs.firefox.enable = true;
   # programs.gnome-terminal.enable = true;
   programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
     gamescopeSession.enable = true; # Enable GameScope session for Steam
   };
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  services.ollama = {
  enable = true;
  acceleration = "cuda";
  # Optional: preload models, see https://ollama.com/library
  loadModels = [ "llama3.2:3b" #"deepseek-r1:1.5b"
# "gpt-oss:20b"
  ];
   };


#   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     # (fenix.complete.withComponents [
      # "cargo"
      # "clippy"
      # "rust-src"
      # "rustc"
      # "rustfmt"
    # ])
    # rust-analyzer-nightly
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     curl
     xclip
     nodejs
     unzip
     lldb
     nixos-shell
     direnv
     mpv
     foot
     kitty
     waybar
     hyprpaper

     # steam removed from here since it's now configured via programs.steam
     python3
     vscode
     postgresql_17_jit
     jetbrains-toolbox
     zed-editor
   ];

   services.openssh.enable = true;


  system.stateVersion = "25.05"; # Did you read the comment?

}
