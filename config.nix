{ pkgs, ... }: {
  nixpkgs.config.allowUnfree =  true;
  environment.enableAllTerminfo = true;

  system.stateVersion = "25.05";

  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  networking.firewall = {
    pingLimit = "--limit 1/minute --limit-burst 5";
    allowedTCPPorts = [22 8200];
  };

  services = {
    openssh = {
      enable = true;
      banner = "-- SSH VTY for Hashicorp Vault test mircovm --";
    };
    vault = {
      dev = true;
      enable = true;
      address = "0.0.0.0:8200";
      devRootTokenID = "root";
    };
  };

  # Regular user for the system
  users.users.user = {
    group = "wheel";
    password = "password";
    isNormalUser = true;
  };
}
