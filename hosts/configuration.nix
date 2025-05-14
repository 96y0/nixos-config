{ config, lib, pkgs, inputs, vars, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot/efi";
		};
		grub = {
			enable = true;
      efiSupport = true;
			devices = [ "nodev" ];
		};
	};

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Bangkok";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  users.users.${vars.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "lp" "networkmanager" ];
  };

  environment = {
    variables = {
      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [

      home-manager

      # Utils
      exfatprogs
      dosfstools
      chrony
      ffmpeg
      mpv
      playerctl
      pulsemixer
      alsa-utils
      openal
      mesa
      yazi
      fzf
      dunst
      htop
      cronie
      upower
      acpi
      udisks
      fuse
      usbutils
      pciutils
      dbus
      brightnessctl
      ripgrep
      wget
      wl-clipboard
      zip
      imagemagick
      wayland-utils
      fastfetch
      microfetch
      cpufetch
      tmux
      stow
      kitty

      waybar
      hyprlock
      hyprshot
      hyprpaper
      xdg-desktop-portal-hyprland

      # Editor
      emacs
      neovim
      nano

      # Dev
      sdl3
      gcc
      gdb
      valgrind
      clang
      clang-tools
      vulkan-tools
      cmake
      cloc
    ]; 
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    font-awesome
    corefonts
    ipafont
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    #package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes 
      '';
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11"; 
}

