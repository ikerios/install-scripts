# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      # virtualization (qemu, libvirt and podman)
      ./virtualization.nix
    ];

  system.autoUpgrade.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  networking.hostName = "eberron";

  time.timeZone = "Europe/Rome";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    vim 
    wget
    curl
  ];

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      networkSocket.openFirewall = true;
    };
  };

  # List services that you want to enable:

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    openFirewall = true;
  };

  services.cockpit = {
    enable = true;
    openFirewall = true;
  };

  #services.fwupd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  networking.firewall.interfaces.podman0.allowedUDPPorts = [ 53 ];

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  system.stateVersion = "23.05";
}
