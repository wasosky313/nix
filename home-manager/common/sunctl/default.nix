{pkgs, ...}: {
  home.packages = with pkgs; [teleport_13 kubectl gum];

}
