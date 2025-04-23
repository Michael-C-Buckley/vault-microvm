_: {
  # Currently this is a testing edition and needs production changes
  services.vault = {
    enable = true;
    address = "0.0.0.0:8200";
    storageBackend = "file";
    listenerExtraConfig = ''tls_disable = 1'';
    extraConfig = ''
      disable_mloc = true
      ui = true
    '';
  };
}
