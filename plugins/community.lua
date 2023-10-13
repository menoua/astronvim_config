return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of importing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

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
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.markdown" },

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
