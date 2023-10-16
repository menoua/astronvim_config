return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- Statusline and winbar
  { import = "astrocommunity.bars-and-lines.heirline-mode-text-statusline" },
  { import = "astrocommunity.bars-and-lines.heirline-vscode-winbar" },

  -- Color schemes
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.nightfox-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.rose-pine" },
  { import = "astrocommunity.colorscheme.monokai-pro-nvim" },
  -- { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Indentation
  { import = "astrocommunity.indent.indent-blankline-nvim" },

  -- Language support
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.cpp" },

  -- Smart column
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },
  {
    "smartcolumn.nvim",
    opts = {
      colorcolumn = "100",
      custom_colorcolumn = { lua = "125" },
      disabled_filetypes = { "neo-tree", "alpha", "help", "text", "markdown" },
    },
  },

  -- Diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      mode = "document_diagnostics",
      action_keys = { -- key mappings for actions in the trouble list
        open_code_href = { "c", "h" }, -- if present, open a URI with more information about the diagnostic
      },
      use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
    },
  },

  -- Telescope extensions
  "gbprod/yanky.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  {
    "nvim-telescope/telescope.nvim",
    config = function(plugin, opts)
      require "plugins.configs.telescope"(plugin, opts) -- include the default astronvim config
      local telescope = require "telescope"

      telescope.setup {
        extensions = {
          file_browser = {
            -- Disable netrw and use telescope-file-browser in its place
            hijack_netrw = true,
          },
        },
      }

      telescope.load_extension "file_browser"
      telescope.load_extension "yank_history"
    end,
  },
}
