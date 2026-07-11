-- Workflow: keymap discovery, command palette, project-wide replace, projects.
-- (persistence.nvim for session restore is a LazyVim default: <leader>qs / ql / qd.)

return {
  -- which-key: label our custom leader groups so the popup reads nicely
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

  -- Legendary: searchable command/keymap palette (Zed's Cmd-P-for-commands feel)
  {
    "mrjones2014/legendary.nvim",
    lazy = false,
    priority = 10000,
    opts = {
      extensions = { which_key = { auto_register = true } }, -- surface which-key maps in the palette
      sort = { frecency = false }, -- no sqlite dependency needed
    },
    keys = {
      { "<leader>fp", "<cmd>Legendary<cr>", desc = "Command palette (legendary)" },
    },
  },

  -- grug-far: project-wide find & replace UI (Zed's multi-file replace)
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

  -- project.nvim: auto-detect project roots + a Telescope picker for them
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
