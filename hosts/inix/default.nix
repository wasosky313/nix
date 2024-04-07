# tudo que for sudo a nivel de sistema

{ config, pkgs, inputs, ... }:
{
  imports = [ # Include the results of the hardware scan.
      inputs.home-manager.nixosModules.default

      ./hardware-configuration.nix
      ../common/global
      ../../modules/desktop
      ../../modules/vm.nix
      ../../modules/solaar-logitech.nix
      ../../modules/yubikey-access.nix
      ../../modules/lact-radeon.nix
    ];


  wasosky = {
    desktop = "gnome";
  };

  services = {

    yubikeyAccess.enable = false; # TODO what's this
    lact.enable = false;          # TODO what's this
    solaarLogitech.enable = false;

    openssh.enable = true;

    # TODO test later
    jellyfin = {
      enable = false;
      user = "wasa";
      openFirewall = true;
    };

    languagetool = {
      enable = false;
      allowOrigin = "*";
    };

    i2p = {
      enable = false;
    };

    zerotierone = {
      enable = true;
      # To remove networks, use the ZeroTier CLI: zerotier-cli leave <network-id>
      # TODO add secrets
      # joinNetworks = [];
    };

  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    fish.enable = false;
    zsh.enable = true;  # TODO meaby in user level is better
  };

  virtualisation = { 

    docker.enable = true;

    libvirtd.enable = true;
  };

  environment = {
    shells = with pkgs; [ bash zsh ];

    systemPackages = with pkgs; [
      vim 
      wget
      pciutils
    ];

    variables = {
      TZ = "America/Sao_Paulo"; # fix for firefox datetime
    };
  };


  networking = {
    hostName = "wasosky-nixos"; # Define your hostname.
    networkmanager.enable = true;
    useDHCP = false;
  };

  users = {
    defaultUserShell = pkgs.zsh;

    users.wasa = {
      isNormalUser = true;
      description = "wasa";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
      ];
    };
  };


  # TODO change to specific module
  # VirtualBox configs
  # virtualisation.libvirtd.enable = true;
  # programs.virt-manager.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "wasa" ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;


  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };



  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      fira-code
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };


  # home-manager
  home-manager = {
    useGlobalPkgs = true;

    extraSpecialArgs = { 
      nixosConfig = config;
      inherit inputs; 
    };

    users = {
      "wasa" = import ../../home-manager/home.nix;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  nix = { 
      settings = {
        experimental-features = [ "nix-command" "flakes" "repl-flake" ];
        auto-optimise-store = true;
        trusted-users = [ "wasa" ];
      };
    };
}

