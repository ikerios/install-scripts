{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    enshrouded-one = {
      image = "docker.io/sknnr/enshrouded-dedicated-server";
      autoStart = false;
      ports = [
        "0.0.0.0:15636:15636/udp"
        "0.0.0.0:15637:15637/udp"
      ];
      environment = {
        SERVER_NAME = "dorcopio";
        SERVER_SLOTS = "2";
        SERVER_PASSWORD = "pissio";
        GAME_PORT = "15636";
        QUERY_PORT = "15637";
      };
      extraOptions = [
        "--pull=newer"
        "--cap-add=sys_nice"
      ];
      volumes = [
        "/root/podman/enshrouded-one/download:/home/steam/enshrouded"
        "/root/podman/enshrouded-one/data:/home/steam/enshrouded/savegame"
      ];
    };
  };
  
  networking.firewall.allowedUDPPorts = [ 15636 15637 ];
}
