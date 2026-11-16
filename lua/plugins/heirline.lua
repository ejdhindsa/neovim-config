-- imperial fists statusline. colors are hardcoded so it looks the same
-- whatever colorscheme is active

return {
  { "nvim-lualine/lualine.nvim", enabled = false },

  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")

      local pal = {
        bg = "#12100b",
        bg_alt = "#1c1913",
        fg = "#e9e2cf",
        gold = "#e3b23c",
        gold_br = "#f5cf5b",
        steel = "#8a8a8a",
        black = "#0a0a0a",
        red = "#c1121f",
        green = "#7fae5a",
        blue = "#5a8fae",
        orange = "#d98c3f",
        purple = "#a98cc8",
      }

      local mode_colors = {
        n = pal.gold,
        i = pal.green,
        v = pal.blue,
        V = pal.blue,
        ["\22"] = pal.blue,
        c = pal.orange,
        s = pal.purple,
        S = pal.purple,
        ["\19"] = pal.purple,
        R = pal.red,
        r = pal.red,
        ["!"] = pal.red,
        t = pal.red,
      }
      local function mode_color()
        return mode_colors[vim.fn.mode()] or pal.gold
      end

      local ViMode = {
        init = function(self)
          self.mode = vim.fn.mode(1)
        end,
        static = {
          names = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "V·LINE",
            ["\22"] = "V·BLOCK",
            c = "COMMAND",
            s = "SELECT",
            S = "S·LINE",
            ["\19"] = "S·BLOCK",
            R = "REPLACE",
            r = "REPLACE",
            ["!"] = "SHELL",
            t = "TERMINAL",
          },
        },
        provider = function(self)
          local key = self.mode:sub(1, 1)
          return "  " .. (self.names[self.mode] or self.names[key] or self.mode) .. " "
        end,
        hl = function()
          return { fg = pal.black, bg = mode_color(), bold = true }
        end,
        update = { "ModeChanged", "MenuPopup" },
      }

      local Git = {
        condition = conditions.is_git_repo,
        init = function(self)
          self.status = vim.b.gitsigns_status_dict or {}
        end,
        hl = { fg = pal.gold_br, bg = pal.bg_alt },
        { provider = function(self)
          return "  " .. (self.status.head or "") .. " "
        end, hl = { bold = true } },
        { provider = function(self)
          local a = self.status.added or 0
          return a > 0 and ("+" .. a .. " ") or ""
        end, hl = { fg = pal.green, bg = pal.bg_alt } },
        { provider = function(self)
          local c = self.status.changed or 0
          return c > 0 and ("~" .. c .. " ") or ""
        end, hl = { fg = pal.orange, bg = pal.bg_alt } },
        { provider = function(self)
          local r = self.status.removed or 0
          return r > 0 and ("-" .. r .. " ") or ""
        end, hl = { fg = pal.red, bg = pal.bg_alt } },
      }

      local FileNameBlock = {
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
      }
      local FileIcon = {
        init = function(self)
          local ext = vim.fn.fnamemodify(self.filename, ":e")
          self.icon, self.icon_color =
            require("nvim-web-devicons").get_icon_color(self.filename, ext, { default = true })
        end,
        provider = function(self)
          return self.icon and (" " .. self.icon .. " ")
        end,
        hl = function(self)
          return { fg = self.icon_color, bg = pal.bg }
        end,
      }
      local FileName = {
        provider = function(self)
          local name = vim.fn.fnamemodify(self.filename, ":.")
          if name == "" then
            return "[No Name]"
          end
          if not conditions.width_percent_below(#name, 0.27) then
            name = vim.fn.pathshorten(name)
          end
          return name
        end,
        hl = { fg = pal.fg, bg = pal.bg },
      }
      local FileFlags = {
        { condition = function()
          return vim.bo.modified
        end, provider = " ●", hl = { fg = pal.gold_br, bg = pal.bg } },
        { condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end, provider = " ", hl = { fg = pal.red, bg = pal.bg } },
      }
      local FileNameBlockFull =
        utils.insert(FileNameBlock, FileIcon, FileName, FileFlags, { provider = "%<" })
      FileNameBlockFull.hl = { bg = pal.bg }

      local Diagnostics = {
        condition = conditions.has_diagnostics,
        init = function(self)
          local sev = vim.diagnostic.severity
          self.errors = #vim.diagnostic.get(0, { severity = sev.ERROR })
          self.warns = #vim.diagnostic.get(0, { severity = sev.WARN })
          self.infos = #vim.diagnostic.get(0, { severity = sev.INFO })
          self.hints = #vim.diagnostic.get(0, { severity = sev.HINT })
        end,
        update = { "DiagnosticChanged", "BufEnter" },
        hl = { bg = pal.bg_alt },
        { provider = " " },
        { provider = function(self)
          return self.errors > 0 and (" " .. self.errors .. " ")
        end, hl = { fg = pal.red } },
        { provider = function(self)
          return self.warns > 0 and (" " .. self.warns .. " ")
        end, hl = { fg = pal.gold } },
        { provider = function(self)
          return self.infos > 0 and (" " .. self.infos .. " ")
        end, hl = { fg = pal.blue } },
        { provider = function(self)
          return self.hints > 0 and (" " .. self.hints .. " ")
        end, hl = { fg = pal.green } },
      }

      local LSPActive = {
        condition = conditions.lsp_attached,
        update = { "LspAttach", "LspDetach", "BufEnter" },
        provider = function()
          local names = {}
          for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            if client.name ~= "copilot" then
              names[#names + 1] = client.name
            end
          end
          if #names == 0 then
            return ""
          end
          return "  " .. table.concat(names, "·") .. " "
        end,
        hl = { fg = pal.black, bg = pal.gold, bold = true },
      }

      local Copilot = {
        condition = function()
          return package.loaded["copilot"] ~= nil
        end,
        provider = "  ",
        hl = { fg = pal.gold_br, bg = pal.bg },
      }

      local FileType = {
        provider = function()
          return " " .. (vim.bo.filetype ~= "" and vim.bo.filetype or "none") .. " "
        end,
        hl = { fg = pal.fg, bg = pal.bg_alt, bold = true },
      }

      local Ruler = {
        provider = " %7(%l/%3L%):%2c %P ",
        hl = { fg = pal.black, bg = pal.gold, bold = true },
      }

      local Align = { provider = "%=" }
      local Space = { provider = " " }

      require("heirline").setup({
        statusline = {
          hl = { bg = pal.bg },
          ViMode,
          Git,
          Space,
          FileNameBlockFull,
          Align,
          Diagnostics,
          Align,
          Copilot,
          LSPActive,
          FileType,
          Ruler,
        },
      })
    end,
  },
}
