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
    chromium
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
    pycharm-community-fhs
    unison-ucm
    vscode-fhs 
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
