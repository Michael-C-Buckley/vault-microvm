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
      microfetch

      # Core Security
      vault
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
