{ config, pkgs, ... }:

{
  home.username = "joronix";
  home.homeDirectory = "/home/joronix";

  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    vscode-extensions.vadimcn.vscode-lldb  # <- codelldb para NixOS
  ];
}
