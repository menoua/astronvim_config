-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local telescope = require "telescope.builtin"
local trouble = require "trouble"
local utils = require "astronvim.utils"
local get_icon = utils.get_icon

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- Telescope extra mappings
    ["<leader> "] = { function() telescope.buffers() end, desc = "Find buffers" },
    ["<leader>f/"] = { function() telescope.live_grep { grep_open_files = true } end, desc = "Find in all buffers" },
    ["<leader>fs"] = { function() telescope.treesitter() end, desc = "Find symbols" },
    ["<leader>gf"] = { function() telescope.git_files() end, desc = "Find symbols" },
    ["<leader>fe"] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File browser" },
    ["?"] = { function() telescope.current_buffer_fuzzy_find() end, desc = "Find words in current buffer" },

    -- Trouble mappings
    ["<leader>x"] = { desc = get_icon("DiagnosticWarn", 1, true) .. "Diagnostics" },
    ["<leader>xx"] = { function() trouble.toggle() end, desc = "Toggle diagnostics" },
    ["<leader>xw"] = { function() trouble.toggle "workspace_diagnostics" end, desc = "Workspace diagnostics" },
    ["<leader>xd"] = { function() trouble.toggle "document_diagnostics" end, desc = "Document diagnostics" },
    ["<leader>xq"] = { function() trouble.toggle "quickfix" end, desc = "Quickfix diagnostics" },
    ["<leader>xl"] = { function() trouble.toggle "loclist" end, desc = "Items from location list" },
    ["gR"] = { function() trouble.toggle "lsp_references" end, desc = "LSP references" },

    -- mappings seen under group name "Buffer"
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
