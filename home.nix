{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/john-dotfiles/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    nvim = "nvim";
    wofi = "wofi";
    rofi = "rofi";
    foot = "foot";
    waybar = "waybar";
  };
in
{
  imports = [
    ./home/hyprland.nix
    ./modules/theme.nix
  ];

  home.username = "winter";
  home.homeDirectory = "/home/winter";
  home.stateVersion = "25.05";
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

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

}
