return {
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

  -- connection urls come from env vars, keep credentials out of git
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
      vim.g.db_ui_show_database_icon = 1
      vim.g.dbs = {
        { name = "store", url = vim.env.DBUI_STORE or "" },
        { name = "corp", url = vim.env.DBUI_CORP or "" },
      }

      -- <leader>S is awkward to hit, so add <leader>s in sql buffers only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql",
        callback = function(args)
          vim.keymap.set({ "n", "v" }, "<leader>s", "<Plug>(DBUI_ExecuteQuery)", {
            buffer = args.buf,
            remap = true,
            silent = true,
            desc = "DB: execute query (fast)",
          })
        end,
      })
    end,
    keys = {
      { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Dadbod UI (SQL)" },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
      code = { sign = false, width = "block", right_pad = 1 },
    },
  },
}
