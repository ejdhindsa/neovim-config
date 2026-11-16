return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      render = "virtual", -- "background" | "foreground" | "virtual"
      virtual_symbol = "󱓻 ",
      virtual_symbol_position = "eol",
      enable_named_colors = true,
      enable_tailwind = false,
    },
    keys = {
      { "<leader>uH", "<cmd>HighlightColors Toggle<cr>", desc = "Toggle color swatches" },
    },
  },

  {
    "uga-rosa/ccc.nvim",
    cmd = { "CccPick", "CccConvert", "CccHighlighterToggle" },
    opts = {
      highlighter = { auto_enable = false, lsp = true },
    },
    keys = {
      { "<leader>cP", "<cmd>CccPick<cr>", desc = "Pick / edit color" },
    },
  },
}
