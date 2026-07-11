-- Polish & fun.

return {
  -- Distraction-free writing (auto-dims non-focused code via twilight)
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 0.72,
        options = { number = false, relativenumber = false, signcolumn = "no" },
      },
      plugins = {
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        twilight = { enabled = true },
      },
    },
    keys = {
      { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
    },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable" },
    opts = {},
    keys = {
      { "<leader>uZ", "<cmd>Twilight<cr>", desc = "Twilight (dim inactive code)" },
    },
  },

  -- Subtle animations (nice on a GPU terminal like WezTerm). Scroll animation
  -- is intentionally OFF — it can feel laggy over WSL/zellij; flip it on if you like.
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function()
      local animate = require("mini.animate")
      return {
        scroll = { enable = false },
        open = { enable = false },
        close = { enable = false },
        cursor = { timing = animate.gen_timing.linear({ duration = 80, unit = "total" }) },
        resize = { timing = animate.gen_timing.linear({ duration = 80, unit = "total" }) },
      }
    end,
  },

  -- Discord Rich Presence.
  -- WSL CAVEAT: Discord runs on Windows and presence.nvim talks to Discord's
  -- IPC socket, which WSL can't reach out of the box. Without an IPC bridge it
  -- simply stays silent (harmless). Modern alternative: vyfor/cord.nvim.
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require("presence"):setup({
        neovim_image_text = "Neovim (WSL)",
        main_image = "neovim",
        enable_line_number = false,
      })
    end,
  },

  -- Coding-time tracking. First launch prompts for your WakaTime API key,
  -- stored in ~/.wakatime.cfg (I won't set keys for you).
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },
}
