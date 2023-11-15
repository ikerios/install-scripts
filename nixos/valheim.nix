{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    valheim-firstworld = {
      image = "ghcr.io/lloesche/valheim-server";
      autoStart = true;
      ports = [
        "0.0.0.0:2456:2456/udp"
        "0.0.0.0:2457:2457/udp"
      ];
      #user = "root:root";
      environment = {
        TZ = "Europe/Rome";
        SERVER_NAME = "firstworld";
        WORLD_NAME = "firstworld";
        SERVER_PASS = "<pwd>>";
        #POST_BOOTSTRAP_HOOK = " apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y full-upgrade ";
        SERVER_PUBLIC = "false";
        ADMINLIST_IDS = "76561198000572249 76561197963433751";
        SERVER_ARGS = " -modifier raids none -modifier portals casual -setkey nobuildcost ";
      };
      extraOptions = [
        "--pull=newer"
        "--cap-add=sys_nice"
      ];
      volumes = [
        "/opt/valheim-server/config:/config"
        "/opt/valheim-server/data:/opt/valheim"
      ];
    };
  };
}
