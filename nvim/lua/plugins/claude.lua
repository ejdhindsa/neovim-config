-- Claude Code integration. Drives the already-authenticated `claude` CLI as a
-- subprocess — so it rides your Claude Team/Pro subscription with NO Anthropic
-- API key and no metered billing (exactly the handoff constraint).
--
-- One-time: make sure `claude` is authenticated in WSL (`claude` → /login).
-- Keys are under <leader>a (see the which-key group label in workflow.lua).

return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal = {
        split_side = "right",
        split_width_percentage = 0.35,
        provider = "snacks",
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Claude: toggle" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude: focus" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Claude: resume" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: select model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add current file" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude: send selection" },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
      { "<leader>ay", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: deny diff" },
    },
  },
}
