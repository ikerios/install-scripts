{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    pihole = {
      image = "pihole/pihole:latest";
      autoStart = true;
      ports = [
        "0.0.0.0:53:53"
        "0.0.0.0:80:80"
      ];
      #user = "root:root";
      environment = {
        TZ = "Europe/Rome";
        VIRTUAL_HOST = "pi.hole";
        PROXY_LOCATION = "pi.hole";
        FTLCONF_LOCAL_IPV4 = "192.168.9.10";
      };
      extraOptions = [
        "--pull=newer"
        "--cap-add=sys_nice"
      ];
      volumes = [
        "/opt/pihole/etc-pihole:/etc/pihole"
        "/opt/pihole/etc-dnsmasq.d:/etc/dnsmasq.d"
      ];
    };
  };
}
