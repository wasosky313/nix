# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, osConfig, pkgs, ... }:
let


in
  {
  imports = [
    inputs.nix-colors.homeManagerModule

    ./common
    ./desktop/hyprland
    ./features/gh.nix
  ];

  home = {
    username = "wasa";
    homeDirectory = "/home/wasa";
  };

  desktops.hyprland = {
    enable = lib.mkIf (osConfig.wasosky.desktop == "hyprland") true;
    wallpaper = ../wallpapers/wallpaper1.jpg;
  };

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-city-dark;

  programs.home-manager.enable = true;

  home.packages = with pkgs; [ 
    aichat
    bottom
    google-chrome
    firefox
    foliate
    idea-community-fhs
    insomnia
    #jetbrains.idea-community
    #jetbrains.pycharm-community
    jq
    lazydocker
    lazygit
    libreoffice
    librewolf
    logseq
    mpv
    postman
    # pycharm-community-fhs
    # jetbrains.pycharm-professional
    unison-ucm
    vscode-fhs
    qbittorrent
    terminator
    telegram-desktop
    spotify
    dbeaver
    thefuck
  ];
  
  programs.zsh = { # mover para outra pasta 
    enable = true;
    enableCompletion = true;
    # enableAutosuggestions = true; # TODO ver se mudou
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update-flake = "sudo nixos-rebuild switch --flake .#inix";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
    enable = true;
    plugins = [ "git" "thefuck" ];
    theme = "robbyrussell";
    };
   };

 ####################

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
