-- Task runner — run npm scripts, build steps, Cypress, etc. from inside nvim.
return {
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction", "OverseerInfo" },
    opts = {
      templates = { "builtin", "vscode" }, -- picks up package.json scripts + .vscode/tasks.json
      task_list = { direction = "bottom", min_height = 12 },
    },
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Overseer: task list" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer: run task" },
      { "<leader>oa", "<cmd>OverseerQuickAction<cr>", desc = "Overseer: quick action" },
    },
  },
}
