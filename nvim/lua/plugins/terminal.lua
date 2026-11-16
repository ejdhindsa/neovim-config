return {
  {
    "swaits/zellij-nav.nvim",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>ZellijNavigateLeftTab<cr>", desc = "Nav left (nvim/zellij)" },
      { "<C-j>", "<cmd>ZellijNavigateDown<cr>", desc = "Nav down (nvim/zellij)" },
      { "<C-k>", "<cmd>ZellijNavigateUp<cr>", desc = "Nav up (nvim/zellij)" },
      { "<C-l>", "<cmd>ZellijNavigateRightTab<cr>", desc = "Nav right (nvim/zellij)" },
    },
    opts = {},
  },

  -- resize only. smart-splits can't move into zellij panes, zellij-nav does that
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {},
    keys = {
      { "<C-Up>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
      { "<C-Down>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
      { "<C-Left>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
      { "<C-Right>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { [[<C-\>]], "<cmd>ToggleTerm direction=float<cr>", mode = { "n", "t" }, desc = "Scratch terminal" },
    },
    opts = {
      open_mapping = [[<C-\>]],
      direction = "float",
      float_opts = { border = "rounded" },
      shell = "zsh",
    },
  },
}
