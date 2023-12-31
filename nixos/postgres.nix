{ config, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all     192.168.9.0/24   md5
      host  all       all     192.168.9.6/0      trust
      host  all       all     192.168.9.100/0    trust
      host  all       all     127.0.0.1/32     trust
      host  all       all     ::1/128          trust
    '';
  };

  networking.firewall.allowedTCPPorts = [ 5432 ];
  networking.firewall.allowedUDPPorts = [ 5432 ];
}
