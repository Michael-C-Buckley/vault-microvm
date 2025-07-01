{
  description = "Microvm for testing Hashicorp Vault";

  # Optional Subsitution (these are enable on my system-wide config)
  # nixConfig = {
  #   extra-substituters = [
  #     "https://microvm.cachix.org"
  #     "https://nix-community.cachix.org"
  #   ];
  #   extra-trusted-public-keys = [
  #     "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
  #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #   ];
  # };

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    microvm = {
      url = "git+https://github.com/astro/microvm.nix?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    microvm,
  }: let
    system = "x86_64-linux";

    mkVaultSystem = type:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit microvm;};
        modules = [
          microvm.nixosModules.microvm
          ./config
          ./config/vault/${type}.nix
        ];
      };

    mkRunner = name: self.nixosConfigurations.${name}.config.microvm.declaredRunner;
  in {
    packages.${system} = {
      default = mkRunner "vault";
      dev = mkRunner "dev";
    };

    nixosConfigurations = {
      vault = mkVaultSystem "prod";
      dev = mkVaultSystem "dev";
    };
  };
}
