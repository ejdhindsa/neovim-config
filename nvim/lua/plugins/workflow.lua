return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "claude" },
        { "<leader>H", group = "harpoon" },
        { "<leader>n", group = "npm / package" },
        { "<leader>o", group = "overseer / tasks" },
        { "<leader>gd", group = "diffview" },
        { "<leader>D", group = "database" },
      },
    },
  },

  {
    "mrjones2014/legendary.nvim",
    lazy = false,
    priority = 10000,
    opts = {
      extensions = { which_key = { auto_register = true } },
      sort = { frecency = false }, -- frecency needs sqlite
    },
    keys = {
      { "<leader>fp", "<cmd>Legendary<cr>", desc = "Command palette (legendary)" },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = { headerMaxWidth = 80 },
    keys = {
      {
        "<leader>sr",
        function()
          require("grug-far").open()
        end,
        mode = { "n", "v" },
        desc = "Search & replace (project)",
      },
    },
  },

  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "package.json", "Cargo.toml", "docker-compose.yml", "Makefile" },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      pcall(function()
        require("telescope").load_extension("projects")
      end)
    end,
    keys = {
      { "<leader>fP", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
  },
}
