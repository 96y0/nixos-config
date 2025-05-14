{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggesttions.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    shellAliases = {

    };

   initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
    ''; 

    # git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      #custom = "$HOME/.oh-my-zsh/custom/";
      #theme = "powerlevel10k/powerlevel10k";
    };
  };

  #users.environment.shells = pkgs.zsh;
}
