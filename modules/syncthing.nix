{ ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "migio";
    dataDir = "/home/migio"; # default location for new folders
    configDir = "/home/migio/.config/syncthing";
    settings = {
      devices = {
        "Phone" = {
          id = "ENBLEMM-MHFC7YB-NGFKAMH-2U7H5FA-4IZORHC-VHNCGAE-X34E6KC-OS5XAA2";
        };
        "Boox" = {
          id = "NMRMMZZ-YISK5VC-X3MFSEV-OAKWY5Z-QEUOH7C-E4Q3ZA5-5WYJ4SD-KGH2GA2";
        };
      };
      folders = {
        "Uni" = {
          id = "vknur-qadnj";
          path = "/home/migio/Documents/Uni";
          devices = [
            "Boox"
            "Phone"
          ];
        };
        "Boox Notes" = {
          id = "16s1j-ydnlv";
          path = "/home/migio/Documents/Boox Notes";
          devices = [
            "Boox"
            "Phone"
          ];
        };
        "Obsidian" = {
          id = "1jnv3-fyc4g";
          path = "/home/migio/Documents/Notes";
          devices = [
            "Boox"
            "Phone"
          ];
        };
        "DnD" = {
          id = "2rusa-g6bxk";
          path = "/home/migio/Documents/Personal/DnD";
          devices = [
            "Boox"
            "Phone"
          ];
        };
        "Ebooks" = {
          id = "gwn2a-pdapp";
          path = "/home/migio/Books";
          devices = [
            "Boox"
            "Phone"
          ];

        };
      };
    };
  };
}
