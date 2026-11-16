return {
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction", "OverseerInfo" },
    opts = {
      templates = { "builtin", "vscode" },
      task_list = { direction = "bottom", min_height = 12 },
    },
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>", desc = "Overseer: task list" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer: run task" },
      { "<leader>oa", "<cmd>OverseerQuickAction<cr>", desc = "Overseer: quick action" },
    },
  },
}
