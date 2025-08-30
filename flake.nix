{
  description = "My basic nixos flake 25.05";

  inputs = {

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    nixpkgs.url = "nixpkgs/25.05";
    home-manager = {

      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    } ;
  };

  outputs = { self, nixpkgs, fenix, home-manager}:

   let
      lib = nixpkgs.lib;
    in {
    packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
    nixosConfigurations = {
      nixos_pc_gnm = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./host/my_nixos_gnm/pc/configuration.nix
        	        ./host/my_nixos_gnm/pc/hardware-configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.joronix = import ./home.nix;
                    }

                    ({ pkgs, ... }: {
                      nixpkgs.overlays = [ fenix.overlays.default ];
                      environment.systemPackages = with pkgs; [
                           fenix.packages.x86_64-linux.complete.toolchain
                           rust-analyzer-nightly
                         ];
                      }
                    )
                  ];


                                    };
      nixos_laptop_gnm = lib.nixosSystem {
        system = "x86_64-linux";
            modules = [ ./host/my_nixos_gnm/laptop/configuration.nix
       	    ./host/my_nixos_gnm/laptop/hardware-configuration.nix
       	        ];
    };

    };


    };

}
