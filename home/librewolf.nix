{ pkgs, inputs, ... }:
{
  programs.librewolf = {
    enable = true;
    
    profiles.default = {
      extensions = with inputs.nur.repos.rycee.firefox-addons; [
        ublock-origin
      ];
      
      settings = {
      };
    };
  };
}
