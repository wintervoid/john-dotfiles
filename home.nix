{ config, pkgs, inputs, ... }:
{
  imports = [
    ./home/hyprland.nix
    ./home/hyprpanel.nix
        inputs.zen-browser.homeModules.beta
  ];
    programs.zen-browser.enable = true;
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.username = "winter";
  home.homeDirectory = "/home/winter";
  home.stateVersion = "25.05";
  programs.kitty.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/john-dotfiles#john-nixos";
      vim = "nvim";
    };
    initExtra = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \\$ '
      nitch
    '';
    profileExtra = ''
      if [-z $WAYLAND_DISPLAY"] && ["XDG_VTNR = 1]; then
      exec hyprland
      fi
    '';
  };

  home.packages = with pkgs; [
    neovim
    playerctl
    blueman
    ripgrep
    gh
    nil
    nixpkgs-fmt
    nodejs
    gcc
    wofi
    nitch
    rofi
    pcmanfm
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        (nix-search-tv.overrideAttrs {
          env.GOEXPERIMENT = "jsonv2";
        })
      ];
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
  ];



}
