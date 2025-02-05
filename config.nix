{ pkgs, ... }: {
  nixpkgs.config.allowUnfree =  true;
  environment.enableAllTerminfo = true;

  system.stateVersion = "25.05";

  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  services.vault = {
    dev = true;
    enable = true;
    devRootTokenID = "root";
  };
}
