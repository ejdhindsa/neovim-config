return {
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = { enabled = true, jump_labels = true },
      },
    },
  },

  -- off because it fights flash for s/S. to try it, enable this and unmap
  -- flash's s/S
  {
    url = "https://codeberg.org/andyg/leap.nvim.git",
    name = "leap.nvim",
    enabled = false,
    keys = {
      { "s", "<Plug>(leap-forward)", mode = { "n", "x", "o" }, desc = "Leap forward" },
      { "S", "<Plug>(leap-backward)", mode = { "n", "x", "o" }, desc = "Leap backward" },
      { "gs", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from window" },
    },
  },

  -- <leader>H because <leader>h is lazyvim's git group
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = function()
      local h = require("harpoon")
      return {
        { "<leader>Ha", function() h:list():add() end, desc = "Harpoon: add file" },
        { "<leader>Hh", function() h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon: menu" },
        { "<leader>Hp", function() h:list():prev() end, desc = "Harpoon: prev" },
        { "<leader>Hn", function() h:list():next() end, desc = "Harpoon: next" },
        { "<leader>1", function() h:list():select(1) end, desc = "Harpoon 1" },
        { "<leader>2", function() h:list():select(2) end, desc = "Harpoon 2" },
        { "<leader>3", function() h:list():select(3) end, desc = "Harpoon 3" },
        { "<leader>4", function() h:list():select(4) end, desc = "Harpoon 4" },
      }
    end,
  },

  {
    "stevearc/aerial.nvim",
    branch = "nvim-0.11", -- master needs nvim 0.12
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = { min_width = 30, default_direction = "right" },
      show_guides = true,
    },
    keys = {
      { "<leader>co", "<cmd>AerialToggle!<cr>", desc = "Outline (aerial)" },
    },
  },

  {
    "chentoast/marks.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      default_mappings = true,
      refresh_interval = 250,
    },
  },
}
