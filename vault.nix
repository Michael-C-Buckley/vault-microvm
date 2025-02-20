{ ... }:

{
  networking.hostName = "vault";
  users.users.root.password = "";
  microvm = {

    # QEMU is the simplest and most straight
    hypervisor = "qemu";
    socket = "control.socket";

    interfaces = [
      {
        # Tap interfaces will be available but will need manual `ip` commands to bring the host side interfaces up
        type = "tap";
        id = "vm-vault";
        mac = "02:00:00:00:00:01";
      }
    ];

    shares = [ {
      # 9P works for imperatively run VMs whereas virtiofs needs extra steps
      proto = "9p";
      tag = "ro-store";
      source = "/nix/store";
      mountPoint = "/nix/.ro-store";
    } ];
  };
}
