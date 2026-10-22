{ ... }:

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
      render-markdown.enable = true;

      lsp-format = {
        enable = true;
        settings = {
          clangd = {
            exclude = [
              "cpp"
              "h"
            ];
          };
        };
      };

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
            "<CR>" = "cmp.mapping.confirm({select = true})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };
      parrot = {
        enable = true;
        callSetup = false;
      };
    };

    lsp.servers = {
      clangd.enable = true;
      nixd.enable = true;
      texlab.enable = true;
      pylsp.enable = true;
      markdown_oxide.enable = true;
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

    extraConfigLua = ''
      require("parrot").setup({
        providers = {
          -- KIT AI Toolbox (KI-Toolbox-API, OpenAI-compatible endpoint)
          kit = {
            name = "kit",
            -- Chat completion endpoint of the KI-Toolbox-API
            endpoint = "https://ki-toolbox.scc.kit.edu/api/v1/chat/completions",
            model_endpoint = "https://ki-toolbox.scc.kit.edu/api/v1/models",
            -- Generate your key in the web UI: https://ki-toolbox.scc.kit.edu/
            -- (Einstellungen > Konto > "API-Schlüssel erstellen")
            api_key = os.getenv("KIT_TOOLBOX_API_KEY"),
            params = {
              chat = { temperature = 0.2, top_p = 1 },
              command = { temperature = 0.2, top_p = 1 },
            },
            -- Cheap/fast model for summarizing chat topics
            topic = {
              model = "alias.simple-local",
              params = { max_tokens = 32 },
            },
            -- KIT model aliases (recommended over raw model IDs)
            -- suffix -local = run on SCC infrastructure at KIT
            -- suffix -gpt / -claude = cloud models (e.g., via Microsoft Azure in Germany)
            models = {
              "alias.simple-local",   -- Mistral 4 Small (cheap, fast)
              "alias.medium-local",   -- DeepSeek V4 Flash
              "alias.complex-local",  -- GLM-5.3 Flash (powerful)
            },
          },
        },
        -- Enable token usage reporting (optional, nice for budgeting via MyLiteLLM)
        report_usage = true,
        system_prompt = {
          chat = [[
            You are a helpful AI assistant integrated into Neovim.
            Answer concisely and precisely. Format answers using Markdown
            where appropriate, and use code blocks for code.
          ]],
          command = [[
            You are an expert Neovim coding assistant.
            Follow the user's instructions exactly.
            Output only the requested text or code, without any
            explanations, comments on your changes, or surrounding markdown fences.
          ]],
        },
        -- UI / behavior
        toggle_target = "tabnew",
        enable_spinner = true,
        spinner_type = "bouncing_ball",
        show_context_hints = true,
        state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/parrot/persisted",
        chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/parrot/chats",
        chat_user_prefix = "🗨:",
        llm_prefix = "🦜:",

        hooks = {
          Ask = function(parrot, params)
            local template = [[
              Answer the following question concisely and accurately.
              Question: {{command}}
            ]]
            local model_obj = parrot.get_model("command")
            parrot.Prompt(params, parrot.ui.Target.tabnew, model_obj, "🤖 Ask ~ ", template)
          end,
          CodeQuestion = function(prt,params)
            local template = [[
              I will ask a question about the following code.
              Read the following Code:

              ```cpp
              {{selection}}
              ```
              Please answer concisely and accurately to the Question:
              {{command}}
            ]]
            local model_obj = prt.get_model("command")
            prt.Prompt(params, prt.ui.Target.tabnew, model_obj, "Code Question: ", template)
          end,
          CommitMsg = function(prt, params)
            local futils = require "parrot.file_utils"
            if futils.find_git_root() == "" then
              prt.logger.warning "Not in a git repository"
              return
            else
              local template = [[
                I want you to generate a short commit message for the changes provided.
                The commit message should include the following:
                One word for the type of change, for example: "feature, maintenance, bugfix"
                and a short description of the changes made, not more than a sentence long.

                The following is the format for the message:
                type1: description1;
                type2: description2

                Here are the changes that should be considered by this message:
                ]] .. vim.fn.system "git diff --no-color --no-ext-diff --staged"
              local model_obj = prt.get_model "command"
              prt.Prompt(params, prt.ui.Target.append, model_obj, nil, template)
            end
          end,
          Explain = function(prt, params)
            local template = [[
              Your task is to take the code snippet from {{filename}} and explain it.
              The goal is to help the reader understand what the code does and how it works.
              Keep the answer as short as possible while still explaining the functionality.

              ```{{filetype}}
              {{selection}}
              ```

              Use the markdown format with codeblocks and inline code.
              Explanation of the code above:
              ]]
            local model = prt.get_model "command"
            prt.logger.info("Explaining selection with model: " .. model.name)
            prt.Prompt(params, prt.ui.Target.tabnew, model, nil, template)
          end,
          ExplainSection = function(prt, params)
            local template = [[
              This is a code file:

              ```{{filetype}}}
              {{filecontents}}
              ``` 

              Your task is to take the following code snippet from the above file and explain it.
              Break down the code's functionality, purpose, key components and how it fits into the context of the whole file.
              The goal is to help the reader understand what the code does and how it works.

              ```{{filetype}}
              {{selection}}
              ```

              Use the markdown format with codeblocks and inline code.
              Explanation of the code above:
              ]]
            local model = prt.get_model "command"
            prt.logger.info("Explaining selection with model: " .. model.name)
            prt.Prompt(params, prt.ui.Target.tabnew, model, nil, template)
          end,
        },
        keymaps = {
          count_tokens = "<leader>pto",
        },
      })

      -- Convenience keybindings
      local function keymap(...) vim.keymap.set(...) end
      keymap("n", "<leader>pc", ":PrtChatNew<CR>", { desc = "Parrot: new chat (popup)" })
      keymap("n", "<leader>pt", ":PrtChatToggle<CR>", { desc = "Parrot: toggle chat" })
      keymap("n", "<leader>pf", ":PrtChatFinder<CR>", { desc = "Parrot: chat finder" })
      keymap("n", "<leader>pm", ":PrtModel<CR>", { desc = "Parrot: switch model" })
      keymap("n", "<leader>pp", ":PrtProvider<CR>", { desc = "Parrot: switch provider" })
      keymap("n", "<leader>pi", ":PrtInfo<CR>", { desc = "Parrot: info" })
      keymap("n", "<leader>ps", ":PrtStop<CR>", { desc = "Parrot: stop generation" })
      keymap("v", "<leader>pq", ":'<,'>PrtCodeQuestion<CR>", { desc = "Parrot: question about code" })
      keymap("v", "<leader>pr", ":'<,'>PrtRewrite<CR>", { desc = "Parrot: rewrite selection" })
      keymap("v", "<leader>pa", ":'<,'>PrtAppend<CR>", { desc = "Parrot: append to selection" })
      keymap("v", "<leader>pb", ":'<,'>PrtPrepend<CR>", { desc = "Parrot: prepend to selection" })
      keymap("n", "<leader>pk", ":'<,'>PrtAsk<CR>", { desc = "Parrot: ask (visual)" })
    '';
  };
}
