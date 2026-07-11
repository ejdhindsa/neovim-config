-- VSCode/Zed-style multi-cursor.
--
-- HEADS UP (as flagged in the handoff): this is a bolt-on that emulates
-- VSCode-style "select next match" multi-cursor. It is NOT the vim-native way.
-- Vim's own tools — macros (q), :substitute, and the `gn` operator + `.` — are
-- more powerful long-term but are a genuine habit shift. Keeping both is fine;
-- just don't expect VM to behave like a "real" vim motion.
--
-- Default keys:
--   <C-n>            select word / next occurrence (normal & visual)
--   <C-Down>/<C-Up>  add cursor vertically
--   n / N            get next / skip occurrence (while in VM mode)
--   q                skip current and get next
--   [ ] then <Tab>   switch between cursor and extend mode
--   <Esc>            leave multi-cursor mode

return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select All"] = "<leader>A",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
      }
      vim.g.VM_theme = "codedark"
      vim.g.VM_silent_exit = 1
    end,
  },
}
