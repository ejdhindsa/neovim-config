-- Window/pane navigation + scratch terminal. zellij owns your real layout
-- (panes, tabs, session persistence) — nvim just cooperates with it.

return {
  -- Ctrl-hjkl: move between nvim splits AND across into zellij panes.
  -- Requires a small zellij-side config too (see README → "zellij integration").
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

  -- smart-splits owns RESIZE (Ctrl-arrows) so it never fights zellij-nav for
  -- Ctrl-hjkl. (smart-splits can't cross into zellij panes anyway — only
  -- tmux/wezterm/kitty — so zellij-nav does the crossing.)
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

  -- toggleterm: quick SCRATCH terminals only (per handoff). zellij keeps
  -- ownership of your real pane/tab layout. <C-\> toggles a floating shell.
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
