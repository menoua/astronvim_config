--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

local utils = require "astronvim.utils"

local config = {
  -- Set colorscheme to use
  colorscheme = "catppuccin",

  -- Set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {},
    g = {
      -- Don't show diagnostics virtual text on start
      diagnostics_mode = 2,

      -- VimTex config
      tex_flavor = "latex",
      tex_indent_items = 0,
      tex_indent_brace = 0,
      vimtex_view_method = "skim",
      vimtex_context_pdf_viewer = "skim",
      vimtex_quickfix_mode = 0,
      vimtex_mappings_enabled = 1,
      vimtex_indent_enabled = 1,
      vimtex_syntax_enabled = 1,
      vimtex_log_ignore = {
        "Underfull",
        "Overfull",
        "specifier changed to",
        "Token not allowed in a PDF string",
      },
      -- vimtex_compiler_latexmk = {
      --   options = '-pdf -verbose -bibtex -file-line-error -synctex=1 --interaction=nonstopmode',
      -- },
    },
  },

  diagnostics = {
    underline = false,
  },

  -- Extend LSP configuration
  lsp = {
    -- Enable servers that you already have installed without mason
    servers = {},
    -- Formatting options
    formatting = {},
    -- Easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },

    -- Add overrides for LSP server settings, the keys are the name of the server
    config = {},
  },

  -- Keyboard mappings
  mappings = {
    -- First key is the mode
    n = {
      ["<leader>fe"] = {
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "File browser",
      },
      ["<leader>fr"] = {
        "<cmd>Telescope bibtex<cr>",
        desc = "Find citation",
      }
    },
    t = {},
  },

  -- Configure plugins
  plugins = {
    {
      "null-ls.nvim",
      opts = function(_, config)
        local null_ls = require("null-ls")

        -- Check supported formatters and linters
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        config.sources = {
          -- Set a formatter
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
        }
        return config
      end,
    },

    -- Add the community repository of plugin specifications
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
    "AstroNvim/astrocommunity",

    -- Color schemes
    { import = "astrocommunity.colorscheme.nightfox" },
    { import = "astrocommunity.colorscheme.kanagawa" },
    { import = "astrocommunity.colorscheme.rose-pine" },
    { import = "astrocommunity.colorscheme.catppuccin" },

    -- Rust language support
    { import = "astrocommunity.pack.rust" },

    -- Python language support (modified version of "astrocommunity.pack.python")
    -- If using conda to manage python environment, start vi from correct environment,
    -- otherwise use VenvSelect to select virtual environment. For pylint to work properly
    -- in a conda environment, it has to be installed in that environment.
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        if opts.ensure_installed ~= "all" then
          opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "python", "toml" })
        end
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = function(_, opts)
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "pyright", "ruff_lsp" })
      end,
    },
    {
      "jay-babu/mason-null-ls.nvim",
      opts = function(_, opts)
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "isort", "black" })
      end,
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "python") end,
    },
    {
      "linux-cultist/venv-selector.nvim",
      opts = {},
      keys = { { "<leader>lv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    },
    {
      -- This is needed for pylint to work in a virtualenv. See https://github.com/williamboman/mason.nvim/issues/668#issuecomment-1320859097
      "williamboman/mason.nvim",
      opts = {
        PATH = "append",
      },
    },
    
    -- Markdown support
    { import = "astrocommunity.pack.markdown" },

    -- Copilot
    -- { import = "astrocommunity.completion.copilot-lua-cmp" },
    -- {
    --   "copilot.lua",
    --   opts = {
    --     suggestion = {
    --       keymap = {
    --         accept = "<C-l>",
    --         accept_word = false,
    --         accept_line = false,
    --         next = "<C-.>",
    --         prev = "<C-,>",
    --         dismiss = "<C/>",
    --       },
    --     },
    --   },
    -- },

    -- Smart column
    { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
    {
      "smartcolumn.nvim",
      opts = {
        colorcolumn = "100",
      },
    },

    -- LaTeX
    { import = "astrocommunity.markdown-and-latex.vimtex" },

    -- Telescope extensions
    "gbprod/yanky.nvim",
    "nvim-telescope/telescope-bibtex.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope.nvim",
      config = function(plugin, opts)
        require("plugins.configs.telescope")(plugin, opts) -- include the default astronvim config
        local telescope = require("telescope")

        telescope.setup({
          extensions = {
            bibtex = {
              -- Depth for the *.bib file
              depth = 1,
              -- Custom format for citation label
              custom_formats = {},
              -- Format to use for citation label.
              -- Try to match the filetype by default, or use 'plain'
              format = "",
              -- Path to global bibliographies (placed outside of the project)
              global_files = {
                "~/Library/texmf/bibtex/bib/Zotero.bib",
              },
              -- Define the search keys to use in the picker
              search_keys = { "author", "year", "title" },
              -- Template for the formatted citation
              citation_format = "{{author}} ({{year}}), {{title}}.",
              -- Only use initials for the authors first name
              citation_trim_firstname = true,
              -- Max number of authors to write in the formatted citation
              -- following authors will be replaced by "et al."
              citation_max_auth = 2,
              -- Context awareness disabled by default
              context = false,
              -- Fallback to global/directory .bib files if context not found
              -- This setting has no effect if context = false
              context_fallback = true,
              -- Wrapping in the preview window is disabled by default
              wrap = false,
            },
            file_browser = {
              -- theme = "ivy",
              -- disables netrw and use telescope-file-browser in its place
              hijack_netrw = true,
            },
          },
        })

        telescope.load_extension("file_browser")
        telescope.load_extension("yank_history")
        telescope.load_extension("bibtex")
      end,
    },
  },

  -- This function is run last and is a good place for configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
  end,
}

return config
