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
      nixos_pc_gnm = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./host/my_nixos_gnm/pc/configuration.nix
        	    ./host/my_nixos_gnm/pc/hardware-configuration.nix
        	    ];

      };

      # nixos_pc_niri= lib.nixosSystem {
      # system = "x86_64-linux";
      #
      #
      # };
    };

     nixosConfigurations = {
      nixos_laptop_gnm = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./host/my_nixos_gnm/laptop/configuration.nix
        	    ./host/my_nixos_gnm/laptop/hardware-configuration.nix
        	    ];

      };
    };

  };
}
