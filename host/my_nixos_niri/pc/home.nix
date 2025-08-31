{ config, pkgs, ... }:

{
  home.username = "joronix";
  home.homeDirectory = "/home/joronix";
  programs.niri = {
    enable = true;
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

    # Usabilidad
    mako
    wl-clipboard
    swaybg
    swayidle
    swaylock
    waybar
    grim
    slurp
    alacritty
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };
}
