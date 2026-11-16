return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- has to load early to take over directory buffers
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
        ["<C-h>"] = false, -- used by zellij-nav
        ["<C-l>"] = false,
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent dir (oil)" },
      { "<leader>-", function() require("oil").toggle_float() end, desc = "Oil (floating)" },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "disabled", -- oil handles directories
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
