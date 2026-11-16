return {
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

  -- scroll animation lags in zellij
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

  -- never shows file or project names so work stuff stays off discord.
  -- the joke changes every 30 min, the timer forces a refresh when idle.
  -- needs an ipc bridge to reach discord from wsl
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      local JOKES = {
        "Coding my life away",
        "Debugging: the 34th Legion of my problems",
        "Only in death does the merge conflict end",
        "Building it like the Imperial Palace depends on it",
        "No bug shall breach these walls (day 47)",
        "Stone and iron. Tabs and spaces.",
        "Bolter rounds beat breakpoints",
        "Perturabo could never (he'd introduce more bugs)",
        "Dorn wept. I pushed to main anyway.",
        "Send help. Also coffee. Mostly coffee.",
      }
      local function current_joke()
        local slot = math.floor(os.time() / 1800) % #JOKES
        return JOKES[slot + 1]
      end

      local presence = require("presence")
      presence:setup({
        -- my own discord app, the default client_id got rejected over the wsl relay
        client_id = "1541850037598953615",
        neovim_image_text = "Neovim (WSL)",
        main_image = "neovim",
        enable_line_number = false,
        editing_text = current_joke,
        reading_text = current_joke,
        file_explorer_text = current_joke,
        git_commit_text = current_joke,
        plugin_manager_text = current_joke,
        workspace_text = "Send help",
        buttons = false,
      })

      local timer = vim.uv.new_timer()
      timer:start(1800000, 1800000, function()
        vim.schedule(function()
          presence:update(nil, false)
        end)
      end)
    end,
  },

  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },
}
