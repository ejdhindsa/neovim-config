-- UI layer. LazyVim ships several of these; we override opts or swap in the
-- standalone versions you asked for.

return {
  -- ── Buffer/tab line ──────────────────────────────────────────────────
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slant",
        show_close_icon = false,
        show_buffer_close_icons = true,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
          { filetype = "neo-tree", text = "  Explorer", highlight = "Directory", separator = true },
        },
      },
    },
  },

  -- ── Cmdline / messages / popupmenu overhaul ─────────────────────────
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = { enabled = false }, -- fidget owns LSP progress
      },
      notify = { enabled = false }, -- snacks.notifier owns vim.notify
      messages = { enabled = true },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- ── LSP progress spinner ─────────────────────────────────────────────
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = { winblend = 0 },
      },
      progress = {
        display = { done_icon = "" },
      },
    },
  },

  -- ── Start screen (replaces snacks dashboard) ─────────────────────────
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    opts = function()
      local header = {
        "",
        "        ▄▄▄▄    ▄▄▄▄▄▄   ▄▄▄▄    ▄▄▄▄  ▄▄  ▄▄ ▄▄▄▄▄▄  ▄▄▄▄  ▄▄  ▄▄",
        "        █   █   █        █   █  █    █ █ ▄▀  █        █    █  ▀▄▄▀ ",
        "        █▄▄▄▀   █▄▄▄     █▄▄▄▀  █▄▄▄▄█ █▀▄    █▄▄▄     █    █   ▄▀▀▄ ",
        "        █   █   █        █   █  █    █ █  ▀▄  █        █    █  █    █",
        "        █▄▄▄▀   █▄▄▄▄▄   █   █  █    █ █   ▀▄ █        █▄▄▄▄█ █    █",
        "",
        "                        ⚜  per aciem ad astra  ⚜",
        "",
      }

      return {
        theme = "doom",
        hide = { statusline = false },
        config = {
          header = header,
          center = {
            { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
            { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
            { action = "Telescope oldfiles", desc = " Recent Files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
            { action = "lua require('persistence').load()", desc = " Restore Session", icon = " ", key = "s" },
            { action = "e $MYVIMRC | cd %:p:h", desc = " Config", icon = " ", key = "c" },
            { action = "Lazy", desc = " Plugins", icon = "󰒲 ", key = "l" },
            { action = "qa", desc = " Quit", icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- ── Indent guides + current-scope (replaces snacks indent) ───────────
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "▏" },
      scope = { enabled = true, show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help", "dashboard", "neo-tree", "oil", "Trouble", "trouble",
          "lazy", "mason", "notify", "toggleterm", "snacks_dashboard",
        },
      },
    },
  },

  -- ── Floating filename in each window corner ──────────────────────────
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 }, padding = 1 },
        hide = { cursorline = true },
        render = function(props)
          local buf = props.buf
          local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
          if name == "" then
            name = "[No Name]"
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(name)
          local modified = vim.bo[buf].modified
          return {
            icon and { " ", icon, " ", guifg = color } or "",
            { name, gui = modified and "bold,italic" or "bold" },
            modified and { " ●", guifg = "#f5cf5b" } or "",
            " ",
          }
        end,
      })
    end,
  },

  -- ── Scrollbar with diagnostic/git/search markers ─────────────────────
  {
    "lewis6991/satellite.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_only = false,
      winblend = 50,
    },
  },

  -- ── Prettier inline diagnostics (replaces default virtual_text) ──────
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      vim.diagnostic.config({ virtual_text = false })
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
          multilines = { enabled = true, always_show = false },
          show_all_diags_on_cursorline = false,
        },
      })
    end,
  },
}
