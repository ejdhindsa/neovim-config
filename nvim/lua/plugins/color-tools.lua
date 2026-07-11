-- Color highlighting (inline swatches) + an interactive color picker.
-- Covers both "colorizer" and "color picker" wants — very handy in Sass/CSS.

return {
  -- Inline swatches for #hex, rgb(), hsl(), and named colors
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      render = "virtual", -- "background" | "foreground" | "virtual"
      virtual_symbol = "󱓻 ",
      virtual_symbol_position = "eol",
      enable_named_colors = true,
      enable_tailwind = false, -- flip on if you ever add Tailwind
    },
    keys = {
      { "<leader>uH", "<cmd>HighlightColors Toggle<cr>", desc = "Toggle color swatches" },
    },
  },

  -- Interactive color picker / converter (:CccPick on a color to edit it)
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
