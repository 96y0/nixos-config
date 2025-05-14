{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
			extraPackages = with pkgs; [
				intel-media-driver
				intel-ocl
				intel-vappi-driver
			];

		};
		bluetooth = {
			enable = true;
		};
		nvidia = {
			modesetting.enable = true;
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			
			prime = {
				offload = {
					enable = true;
					enableOffloadCmd = true;
				};
				intelBusId = "PCI:0:2:0";
				nvidiaBusId = "PCI:1:0:0";
			};
		};
	};

	services = {
		xserver.videoDrivers = ["nvidia"];

		flatpak.enable = true;		
		blueman.enable = true;
		tlp.enable = false;
		auto-cpufreq.enable = true;

		printing = {
			enable = true;
			drivers = with pkgs; [ hplip ];
		};
		pipewire = {
			enable = true;
			pulse.enable = true;
			#jack.enable = true;
		};
	};

  environment.systemPackages = with pkgs; [
  	
  ];
}
