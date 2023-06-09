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
      -- Leader key
      mapleader = " ",

      -- Background transparency
      transparency = 0.85,

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
    update_in_insert = false,
  },

  -- Extend LSP configuration
  lsp = {
    -- Enable servers that you already have installed without mason
    servers = {},

    -- Formatting options
    formatting = {
      format_on_save = {
        enabled = true,                      -- Set to false to disable autoformatting entirely
        allow_filetypes = { "lua", "rust" }, -- Whitelist file types to be formatted on save
        -- ignore_filetypes = { "markdown", "python" }, -- Blacklist file types to be formatted on save
      },
    },

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
      -- Telescope file browser extension
      ["<leader>fe"] = {
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "File browser",
      },
      -- Telescope bibtex extension
      ["<leader>fx"] = {
        "<cmd>Telescope bibtex<cr>",
        desc = "Insert bibtex citation",
      },

      -- Open dashboard when closing last buffer
      ["<leader>c"] = {
        function()
          local bufs = vim.fn.getbufinfo { buflisted = true }
          require("astronvim.utils.buffer").close(0)
          if utils.is_available "alpha-nvim" and not bufs[2] then require("alpha").start(true) end
        end,
        desc = "Close buffer",
      },
    },
    t = {},
  },

  -- Configure plugins
  plugins = {
    -- Customize dashboard header
    "MaximilianLloyd/ascii.nvim",
    {
      "goolord/alpha-nvim",
      opts = function(_, opts)
        opts.section.header.val = require("ascii").art.misc.skulls.threeskulls_big_v1
        return opts
      end,
    },

    -- Disable better escape
    { "max397574/better-escape.nvim",                        enabled = false },

    -- LSP floating signature
    {
      "ray-x/lsp_signature.nvim",
      event = "BufRead",
      config = function() require("lsp_signature").setup() end,
    },

    -- Configure linters/formatters through null-ls
    {
      "null-ls.nvim",
      opts = function(_, config)
        local null_ls = require "null-ls"

        -- Check supported formatters and linters
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        config.sources = {
          null_ls.builtins.formatting.stylua,
        }
        return config
      end,
    },

    -- Add the community repository of plugin specifications
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
    "AstroNvim/astrocommunity",

    -- Color schemes
    -- Choose which to enable at the top of the file
    { import = "astrocommunity.colorscheme.nightfox" },
    { import = "astrocommunity.colorscheme.kanagawa" },
    { import = "astrocommunity.colorscheme.rose-pine" },
    { import = "astrocommunity.colorscheme.catppuccin" },
    { import = "astrocommunity.colorscheme.monokai-pro" },

    -- Transparency
    -- To toggle transparent mode, type command ":TransparentToggle"
    { import = "astrocommunity.utility.transparent-nvim" },

    -- Indentation
    { import = "astrocommunity.indent.indent-blankline-nvim" },
    {
      "indent-blankline.nvim",
      opts = {
        show_current_context = true,
        show_current_context_start = false,
      },
    },

    -- Lua language support
    { import = "astrocommunity.pack.lua" },

    -- Rust language support
    { import = "astrocommunity.pack.rust" },

    -- Python language support
    -- If using conda to manage python environment, start vi (or neovide) from the target
    -- environment, otherwise use VenvSelect to select virtual environment. For pylint to
    -- work properly in a conda environment, it has to be installed in that environment.
    { import = "astrocommunity.pack.python" },

    -- Markdown support
    { import = "astrocommunity.pack.markdown" },

    -- Copilot (uncomment to enable)
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
        custom_colorcolumn = { lua = "125" },
        disabled_filetypes = { "NvimTree", "lazy", "mason", "help", "text", "markdown" },
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
        require "plugins.configs.telescope" (plugin, opts) -- include the default astronvim config
        local telescope = require "telescope"

        telescope.setup {
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
              -- Disable netrw and use telescope-file-browser in its place
              hijack_netrw = true,
            },
          },
        }

        telescope.load_extension "file_browser"
        telescope.load_extension "yank_history"
        telescope.load_extension "bibtex"
      end,
    },
  },

  -- This function is run last and is a good place for configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Neovide-specific configuration
    if vim.g.neovide then
      -- Helper function for transparency formatting
      local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.85))) end

      -- g:neovide_transparency=0 unifies transparency of content and title bar
      vim.g.neovide_transparency = 0.0
      vim.g.neovide_background_color = "#0f1117" .. alpha()
    end
  end,
}

return config
