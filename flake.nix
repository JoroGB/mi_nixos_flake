{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs}:
  
   let 
      lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos_prueba = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix];

      };
    };
  };
}
