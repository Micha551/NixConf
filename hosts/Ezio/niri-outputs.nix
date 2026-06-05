{ ... }:

{
  programs.niri.settings = {
    outputs = {
      "HDMI-A-1" = {
        scale = 1.0;
        mode = {
          height = 1080;
          width = 1920;
          refresh = 144.001;
        };
        position.x = 0;
        position.y = 0;
      };
    };
  };
}
