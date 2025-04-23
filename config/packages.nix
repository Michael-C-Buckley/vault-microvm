{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs;
    map lib.lowPrio [
      # General Utilities
      gitMinimal
      curl

      # Core Security
      openssl
      sops
      rage
      pinentry
      gnupg

      # PKI
      cfssl
      step-cli
    ];
}
