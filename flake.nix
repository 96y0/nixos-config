{
  description = "A very basic flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Zen-browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, home-manager, home-manager-stable, ... }: 
  let
    vars = {
      system = "x86_64-linux";
      hostname = "nixos-vm";
      user = "watson";
      editor = "nvim";
      terminal = "wezterm";
    };
  in
  {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs vars nixpkgs nixpkgs-stable home-manager home-manager-stable;
      }
    );

    homeConfigurations.${vars.user} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${vars.system};
      extraSpecialArgs = { inherit inputs vars; };
      modules = [ ./home/home.nix ];
    };
  };
}
