{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    colorschemes.kanagawa.enable = true;
    colorschemes.kanagawa.settings.theme = "dragon";
    colorschemes.kanagawa.settings.background.dark = "dragon";

    opts = {
      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      number = true;
    };

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
      gitsigns.enable = true;
      lsp-config.enable = true;
      lsp.enable = true;
      lsp-format.enable = true;

      vimtex = {
        enable = true;
        settings = {
          view_method = "zathura";
          compiler_method = "latexrun";
        };
      };

      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          filesystem = {
            follow_current_file = {
              enabled = true;
              leave_dirs_open = true;
            };
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };
    };

    lsp.servers = {
      clangd.enable = true;
      nixd.enable = true;
      texlab.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>n";
        options.silent = true;
        action = "<cmd>Neotree focus<CR>";
      }
      {
        mode = "n";
        key = "<leader>s";
        options.silent = true;
        action = "<cmd>Neotree filesystem toggle<CR>";
      }
      {
        mode = "n";
        key = "<leader>f";
        options.silent = true;
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>g";
        options.silent = true;
        action = "<cmd>Telescope git_status<CR>";
      }
      {
        mode = "n";
        key = "<C-f>";
        options.silent = true;
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>gp";
        options.silent = true;
        action = "<cmd>Gitsigns preview_hunk_inline<CR>";
      }
    ];

    autoCmd = [
      {
        command = "Neotree filesystem reveal right";
        event = "VimEnter";
      }
    ];

    extraConfigLua = "";
  };
}
