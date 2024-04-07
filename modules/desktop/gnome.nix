{config, lib, pkgs, ...}:
with lib;
let 
  cfg = config.wasosky.desktop;
in 
{

  config = mkIf (cfg == "gnome") {
    services.xserver = {
      enable = true;
      layout = "br";
      xkbVariant = "";
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

    # TODO set video driver based on config
      videoDrivers = ["intel"];
    
    };

    environment.systemPackages = with pkgs; [
      pinentry
      pinentry-gnome
      gnome.gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.browser-gnome-extension
    ];

    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
}
