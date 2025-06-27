{
  description = "My basic nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs}:
  
   let 
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      my_nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./my_nixos_gnm/configuration.nix];

      };
    };
  };
}
