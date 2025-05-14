{ pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

  services.spice-vdagentd.enable = true;
  services.spice-webdavd.enable = true;
  services.qemuGuest.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  environment.systemPackages = with pkgs; [

  ];
}
