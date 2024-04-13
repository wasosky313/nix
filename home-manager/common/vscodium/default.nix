{pkgs, ...}: {
  home.packages = with pkgs; [vscodium python311 poetry teleport_13 kubectl gum]; # TODO send to sunctl file

}
