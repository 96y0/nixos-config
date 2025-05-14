# { inputs, nixpkgs, nixpkgs-stable, home-manager, home-manager-stable, vars, ... }:
{ inputs, nixpkgs, home-manager, vars, ... }:

{
  laptop = nixpkgs.lib.nixosSystem {
    system = "${vars.system}";
    specialArgs = {
      inherit inputs vars;
      host = {
        hostname = "${vars.hostname}";
      };
    };
    modules = [
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };

  vm = nixpkgs.lib.nixosSystem {
    system = "${vars.system}";
    specialArgs = {
      inherit inputs vars;
      host = {
        hostname = "${vars.hostname}";
      };
    };
    modules = [
      ./vm
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
