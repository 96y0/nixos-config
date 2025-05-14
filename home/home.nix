{ pkgs, inputs, nixpkgs, home-manager, vars, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./modules
    # ./packages.nix
  ];

  home = {
    username = "${vars.user}";
    homeDirectory = "/home/${vars.user}";
    stateVersion = "24.11";

    packages = with pkgs; [ 
      
      # inputs.zen-browser.packages."${vars.system}".default.override {
      #   nativeMessagingHosts = [firefoxpwa];
      # }

      audacity
      obs-studio
      obsidian
      pavucontrol
      aseprite
      krita
      gimp
      thunderbird
      qbittorrent
      lmms
      simple-scan
      eog
      loupe
      gedit
      spotify
      eww
      #minecraft
      #davinci-resolve
      #kitty
    ];
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    # package = pkgs.nixFlakes;
    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes 
      '';
  };
  nixpkgs.config.allowUnfree = true;
}
