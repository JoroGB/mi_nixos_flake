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
      system = "x86_64-linux";
      
      # Crear pkgs con el overlay de fenix
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ fenix.overlays.default ];
      };
      
    in {
    nixosConfigurations = {
      nixos_pc_gnm = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit fenix; };
        modules = [ ./host/my_nixos_gnm/pc/configuration.nix
        	        ./host/my_nixos_gnm/pc/hardware-configuration.nix
        	        ./common_flakes/rust.nix
        	        # Home manager
        	        home-manager.nixosModules.home-manager
        	        {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;
                      home-manager.extraSpecialArgs = { inherit fenix; };
                      home-manager.users.joronix = import ./home/home.nix;
                    }
        	        ];

      };
    };


   };

}
