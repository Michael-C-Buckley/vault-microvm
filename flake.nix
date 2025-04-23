{
  description = "Microvm for testing Hashicorp Vault";

  nixConfig = {
    extra-substituters = [
      "https://microvm.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.follows = "microvm/nixpkgs";
    microvm.url = "github:astro/microvm.nix";
  };

  outputs = {
    self,
    nixpkgs,
    microvm,
  }: let
    system = "x86_64-linux";
  in {
    packages.${system}.default = self.nixosConfigurations.vault.config.microvm.declaredRunner;

    nixosConfigurations.vault = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit microvm;};
      modules = [
        microvm.nixosModules.microvm
        ./config
      ];
    };
  };
}
