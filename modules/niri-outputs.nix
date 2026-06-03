{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.niri.settings = {
    outputs = {
      "eDP-1" = {
        scale = 2.0;
        mode = {
          height = 2160;
          width = 3840;
          refresh = 59.997;
        };
        position.x = 0;
        position.y = 0;
      };
      "DP-6" = {
        scale = 1.0;
        mode = {
          height = 1080;
          width = 1920;
          refresh = 144.;
        };
        position.x = 1920;
        position.y = 0;
      };
    };
  };
}
