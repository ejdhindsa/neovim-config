-- Snacks is LazyVim's QOL swiss-army knife. We keep the good bits and turn off
-- the features we're covering with dedicated plugins, so nothing double-renders.
--
-- Still on (LazyVim defaults): lazygit (<leader>gg — needs the lazygit binary,
-- which you have), scratch buffers, gitbrowse, rename-file, bufdelete, statuscolumn.

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false }, -- → dashboard-nvim
      indent = { enabled = false }, -- → indent-blankline
      scroll = { enabled = false }, -- smoother over WSL/zellij; flip on if you want animated scroll
      notifier = { enabled = true, timeout = 3000 },
      input = { enabled = true }, -- replaces the (archived) dressing.nvim input
      words = { enabled = true }, -- highlight/navigate references under cursor
      bigfile = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = {
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit" },
      { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git browse (open in browser)" },
      { "<leader>.", function() require("snacks").scratch() end, desc = "Toggle scratch buffer" },
      { "<leader>S", function() require("snacks").scratch.select() end, desc = "Select scratch buffer" },
    },
  },
}
