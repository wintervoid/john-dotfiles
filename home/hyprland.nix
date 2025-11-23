{ pkgs, ... }:
{
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    splash_offset = 2.0;

    preload = [
      "~/john-dotfiles/assets/nixos-wallpaper-catppuccin-mocha.png"
    ];

    wallpaper = [
      "eDP-1,~/john-dotfiles/assets/nixos-wallpaper-catppuccin-mocha.png"
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Monitor configuration
      monitor = [
        ",preferred,auto,1.0"
        # "eDP-1,1920x1080@60,0x0,1.0"
      ];

      # Program variables
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";
      "$reload_waybar" = "pkill waybar; waybar &";
      "$snip" = "snip";
      "$mainMod" = "SUPER";

      # Autostart
      exec-once = [
        "hyprpanel"
        "hyprpaper"
      ];

      # Environment variables
      env = [
        "GTK_THEME,Tokyo-Night-Dark"
        "GTK_ICON_THEME,Adwaita"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
      ];

      # General settings
      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Misc settings
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_rate = 35;
        repeat_delay = 200;

        touchpad = {
          natural_scroll = false;
        };
      };

      # Cursor configuration
      cursor = {
        inactive_timeout = 30;
        no_hardware_cursors = true;
      };

      # Per-device configuration
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Keybindings
      bind = [
        # Application shortcuts
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, R, exec, $reload_waybar"
        "$mainMod, S, exec, $snip"

        # Move focus with vim keys
        "$mainMod, l, movefocus, l"
        "$mainMod, h, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod ALT, k, workspace, e+1"
        "$mainMod ALT, j, workspace, e-1"

        # Move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Media controls
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioStop, exec, playerctl stop"
        
        # Volume controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];
    };
  };
}
