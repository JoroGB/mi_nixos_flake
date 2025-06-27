{ config, lib, pkgs, ... }: 
 

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nixos"; # Define your hostname.
  # Set your time zone.
  time.timeZone = "America/Costa_Rica";
  time.hardwareClockInLocalTime = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.joronix = {
     password = "fungy2005";
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
       nushell
     ];
   };

   programs.firefox.enable = true;
   programs.gnome-terminal.enable = true;
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     curl
     google-chrome
     
     warp-terminal
     rustup
     gcc
     nixos-shell     
     direnv
     vscode
   ];

  system.stateVersion = "25.05"; # Did you read the comment?

}
