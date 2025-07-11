{pkgs, ...}: {
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_hardened;
  environment.enableAllTerminfo = true;
  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.lix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  networking.firewall = {
    pingLimit = "--limit 1/minute --limit-burst 5";
    allowedTCPPorts = [22 8200];
  };

  services.openssh = {
    banner = "\n-- SSH VTY for Hashicorp Vault test mircovm --\n";
    enable = true;
  };
}
