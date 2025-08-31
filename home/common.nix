{config, pkgs,...}:
# let
  # fenixPkgs = pkgs.fenix.packages.x86_64-linux;
# in
{
  home.packages = with pkgs; [
    # fenixPkgs.latest.complete
    pkgs.complete
  ];

# end config
}
