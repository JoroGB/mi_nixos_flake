{ config, pkgs, ... }:

{
  home.username = "joronix";
  home.homeDirectory = "/home/joronix";
  
  home.sessionVariables = {
  XDG_RUNTIME_DIR = "/run/user/${toString config.home.username}";
  WAYLAND_DISPLAY = "wayland-0";
  DISPLAY = ":0"; # solo necesario si lanzas apps X11 vía XWayland
}; 

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    discord-ptb
    warp-terminal
    pomodoro

    brave
    google-chrome
    vivaldi
  ];
}
