_: {
  # Currently this is a testing edition and needs production changes
  services.vault = {
    dev = true;
    enable = true;
    address = "0.0.0.0:8200";
    devRootTokenID = "root";
  };
}
