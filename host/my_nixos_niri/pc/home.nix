{ config, pkgs, ... }:

{
  home.username = "joronix";
  home.homeDirectory = "/home/joronix";




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
    fuzzel
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    mako
    waybar
    wl-clipboard
    swaybg
    swayidle
    swaylock
    grim
    slurp
    alacritty
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };
}
