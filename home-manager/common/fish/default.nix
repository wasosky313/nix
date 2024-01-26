{pkgs, lib, config, ...}: 
let
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
  hasLazydocker = hasPackage "lazydocker";
  hasLazygit = hasPackage "lazygit";
  hasZellij = hasPackage "zellij";
in
{
  home.packages = with pkgs; [
    fd 
    fzf
    ripgrep
    ];

  programs.fish = {
    enable = true;

    shellAliases = {
      mt = "mix test";
      g = "git";
      n = "nvim .";

      lzd = lib.mkIf hasLazydocker "lazydocker";
      lzg = lib.mkIf hasLazygit "lazygit";


      zj = lib.mkIf hasZellij "zellij";
      zje = lib.mkIf hasZellij "zellij run -- nvim .";

      ",," = "nix_run";
      ",." = "nix_shell_fish";
    };

    
    functions = {
      fish_greeting = "";

      nix_run = "nix run nixpkgs#argv";

      nix_shell_fish = "nix shell nixpkgs#argv -c fish";

      pythonEnv = {
        description = "start a nix-shell with given python packages";
        argumentNames = ["pythonVersion"];
        body = ''
        if set -q argv[2]
          set argv $argv[2..-1]
        end
      
        for el in $argv
          set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
        end
      
        nix-shell -p $ppkgs
        '';
      };

    };

    # TODO this should be handled by yubikey-agent
    interactiveShellInit = ''
      set -x GPG_TTY (tty)
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';
  };

  programs.starship.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
