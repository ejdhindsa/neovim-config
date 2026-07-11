-- Completion + AI ghost text.
-- Completion engine is blink.cmp (LazyVim default: fast, Rust-fuzzy, works with
-- LuaSnip + friendly-snippets, which are already on via LazyVim).

return {
  -- Copilot ghost-text autocomplete. Per the handoff, autocomplete stays on
  -- Copilot (rides your existing Copilot subscription — run `:Copilot auth` once).
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        keymap = {
          accept = "<M-l>", -- Alt-l accepts the ghost suggestion (insert mode)
          accept_word = "<M-;>",
          accept_line = "<M-CR>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = { markdown = true, help = true, gitcommit = true },
    },
  },

  -- Copilot owns ghost text, so switch blink's own ghost text off (no clash).
  {
    "saghen/blink.cmp",
    opts = {
      completion = { ghost_text = { enabled = false } },
    },
  },
}
