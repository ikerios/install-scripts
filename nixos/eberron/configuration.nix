{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./valheim.nix
      ./enshrouded.nix
    ];

  #  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "mitigations=off" ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  networking.hostName = "eberron";
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "it";
  };

  services.xserver.enable = false;

  security.virtualisation.flushL1DataCache = "never";

  virtualisation = {
    libvirtd = {
      enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      networkSocket.openFirewall = true;
    };
  };

  users.users.ikerios = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirt" "podman" ];
    packages = with pkgs; [ ];
    #openssh.authorizedKeys.keys = [
    #  ""
    #]
  };

  environment.systemPackages = with pkgs; [ nvd btop ];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    #settings.PasswordAuthentication = false;
    #settings.KbdInteractiveAuthentication = false;
    openFirewall = true;
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  networking.firewall.interfaces.podman0.allowedUDPPorts = [ 53 ];

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  system.copySystemConfiguration = true;

  system.stateVersion = "23.11";
}
