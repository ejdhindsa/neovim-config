-- Language-specific extras layered on top of the LazyVim lang.* extras.

return {
  -- Extra Treesitter parsers spanning your whole stack (LazyVim merges these)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bash", "lua", "luadoc", "vim", "vimdoc",
        "javascript", "jsdoc", "typescript", "tsx", "vue",
        "css", "scss", "html", "json", "yaml", "toml",
        "dockerfile", "sql", "rust", "cpp", "c",
        "markdown", "markdown_inline", "regex", "gitcommit", "git_rebase", "diff", "printf",
      })
    end,
  },

  -- package.json: latest/outdated versions inline
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    opts = { package_manager = "npm", autostart = true, hide_up_to_date = false },
    keys = {
      { "<leader>ns", function() require("package-info").show() end, desc = "npm: show versions" },
      { "<leader>nu", function() require("package-info").update() end, desc = "npm: update package" },
      { "<leader>ni", function() require("package-info").install() end, desc = "npm: install package" },
      { "<leader>nc", function() require("package-info").change_version() end, desc = "npm: change version" },
    },
  },

  -- MySQL client via dadbod-ui (plugins come from the lang.sql extra).
  -- Add DB connections WITHOUT committing secrets — prefer an env var:
  --   export DBUI_MYSQL_DEV='mysql://user:pass@127.0.0.1:3306/yourdb'
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
      vim.g.db_ui_show_database_icon = 1
      -- Example — uncomment and rely on the env var so no password lands in git:
      -- vim.g.dbs = { { name = "dev", url = vim.env.DBUI_MYSQL_DEV or "" } }
    end,
    keys = {
      { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Dadbod UI (SQL)" },
    },
  },

  -- render-markdown look (plugin comes from the lang.markdown extra)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
      code = { sign = false, width = "block", right_pad = 1 },
    },
  },
}
