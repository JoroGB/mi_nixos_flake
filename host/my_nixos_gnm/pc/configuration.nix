# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }: 

  
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
	nixpkgs.overlays = [
    		(import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 # nvidia drivers
   
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # Enable 32-bit graphics support for Steam
  services.xserver.videoDrivers = ["nvidia"];
 
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true;

    open = true;

    nvidiaSettings = true;

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


  
  services.flatpak.enable = true;
  # Configure keymap in X11
   services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
   services.xserver = {
   enable = true;
   displayManager.gdm.enable = true;
   desktopManager.gnome.enable = true;
   };
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
     extraGroups = [ "wheel" ]; # Enable 'sudo' for the user.
     packages = with pkgs; [
       tree
       nushell
       neovim
       zellij	
     ];
   };

 # myslq service
   services.mysql = {
   enable = true;
   package = pkgs.mysql84;
#   rootPassword = "";
};


   programs.firefox.enable = true;
   programs.gnome-terminal.enable = true;
   programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
     gamescopeSession.enable = true; # Enable GameScope session for Steam
   };
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
     gcc
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     curl
     brave
     google-chrome
     vivaldi 
     
     warp-terminal
     pomodoro     
     nixos-shell     
     direnv
     conda
     # steam removed from here since it's now configured via programs.steam
     
     docker_28
     python3
     vscode
     rPackages.Anaconda
     postgresql_17_jit
     jetbrains-toolbox
     zed-editor     
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #  enable = true;
   # enableSSHSupport = true;
   #};

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   #services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

