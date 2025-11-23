{ pkgs, ... }: {
  # ...
  programs.firefox = {
    enable = true;
    # ...
    profiles.default = {
      extensions = {
        packages = with pkgs.firefoxAddons; [
          ublock-origin
        ];
        # only works for some addons
        settings."uBlock0@raymondhill.net".settings = {
          selectedFilterLists = [
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-unbreak"
            "ublock-quick-fixes"
          ];
        };
      };

      # optional: without this the addons need to be enabled manually after first install
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
    }
  }
  
textfox = {
    enable = true;
    profile = "default";
    config = {
        # Optional config
    };
};
}
