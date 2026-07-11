-- File navigation — you wanted BOTH paradigms:
--   • oil.nvim  → PRIMARY. Edit a directory like a buffer (rename/create/
--     delete by editing lines). Open the current file's dir with `-`.
--   • neo-tree  → BACKUP sidebar tree (closest to Zed's project panel), <leader>e.

return {
  -- oil.nvim (primary)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- needs to be present to take over directory buffers
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 4,
        max_width = 120,
        max_height = 40,
      },
      keymaps = {
        ["q"] = "actions.close",
        ["<C-h>"] = false, -- leave <C-h> for window nav (zellij-nav)
        ["<C-l>"] = false,
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent dir (oil)" },
      { "<leader>-", function() require("oil").toggle_float() end, desc = "Oil (floating)" },
    },
  },

  -- neo-tree (backup sidebar)
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "disabled", -- oil owns directory buffers
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = { width = 32 },
    },
  },
}
