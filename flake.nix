{
  description = "Microvm for testing Hashicorp Vault";

  nixConfig = {
    extra-substituters = [ "https://microvm.cachix.org" ];
    extra-trusted-public-keys = [ "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, microvm }: 
    let 
      system = "x86_64-linux";
    in {
    packages.${system}.default = self.nixosConfigurations.vault.config.microvm.declaredRunner;

    nixosConfigurations.vault = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit microvm;};
      modules = [
        microvm.nixosModules.microvm
        ./config.nix
        ./vault.nix
      ];
    };
  };
}
