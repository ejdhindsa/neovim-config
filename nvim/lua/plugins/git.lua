-- Git stack. gitsigns + lazygit come from LazyVim/snacks; we enable inline
-- blame and add diffview, gitlinker, and conflict resolution.
--   • lazygit  → <leader>gg  (Snacks float — just needs the lazygit binary, ✓)

return {
  -- Inline blame + gutter hunks (gitsigns is a LazyVim default)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 400,
        virt_text_pos = "eol",
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "   <author>, <author_time:%R> · <summary>",
    },
  },

  -- Side-by-side diffs + file/branch history (PR-review style)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gdd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: working tree" },
      { "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
      { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: this file's history" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: branch history" },
    },
    opts = {
      enhanced_diff_hl = true,
    },
  },

  -- Yank / open a permalink to the current line (works with Bitbucket remotes)
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Copy git permalink" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open line in browser" },
    },
  },

  -- Highlighted merge-conflict resolution: co/ct/cb/c0, ]x / [x to navigate
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = { default_mappings = true },
  },
}
