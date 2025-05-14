{
  programs.wezterm = {
    enable = true;
    enableBashIntegation = true;
    enableZshIntegation = true;
    extraConfig = "$HOME/.wezterm.lua";
  };
}
