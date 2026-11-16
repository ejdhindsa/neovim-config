return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = "<M-l>",
          accept_word = false, -- duplicate keymap warning otherwise
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = { markdown = true, help = true, gitcommit = true },
    },
  },

  -- copilot already does ghost text
  {
    "saghen/blink.cmp",
    opts = {
      completion = { ghost_text = { enabled = false } },
    },
  },
}
