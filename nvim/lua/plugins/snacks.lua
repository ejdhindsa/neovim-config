-- Snacks is LazyVim's QOL swiss-army knife. We keep the good bits, disable the
-- pieces covered by dedicated plugins, and turn the built-in dashboard into a
-- "FOR DORN" / Imperial Fists start screen.
--
-- Still on (LazyVim defaults): lazygit (<leader>gg), scratch buffers, gitbrowse,
-- rename-file, bufdelete, statuscolumn.

-- ── FOR DORN block wordmark (built in Lua so the rows always line up) ───────
local FONT = {
  ["F"] = { "█████", "█    ", "████ ", "█    ", "█    " },
  ["O"] = { "█████", "█   █", "█   █", "█   █", "█████" },
  ["R"] = { "████ ", "█   █", "████ ", "█  █ ", "█   █" },
  ["D"] = { "████ ", "█   █", "█   █", "█   █", "████ " },
  ["N"] = { "█   █", "██  █", "█ █ █", "█  ██", "█   █" },
  [" "] = { "   ", "   ", "   ", "   ", "   " },
}
local function banner(word)
  local rows = { "", "", "", "", "" }
  for i = 1, #word do
    local g = FONT[word:sub(i, i)] or FONT[" "]
    for r = 1, 5 do
      rows[r] = rows[r] .. g[r] .. (i < #word and " " or "")
    end
  end
  return table.concat(rows, "\n")
end

-- ── Rotating battle-cry ─────────────────────────────────────────────────────
local quotes = {
  '"Pain is an illusion of the senses; despair, of the mind." — Rogal Dorn',
  '"Only in death does duty end."',
  '"A wall has two sides." — Rogal Dorn',
  '"No bug shall breach these walls."',
  '"Build it as though the Palace itself depends on it."',
  '"Stone and iron. Discipline and duty."',
}
math.randomseed(os.time())
local quote = quotes[math.random(#quotes)]

-- ── Imperial Fists palette for the dashboard highlight groups ───────────────
local function dorn_colors()
  local p = { gold = "#e3b23c", gold_br = "#f5cf5b", fg = "#e9e2cf", red = "#c1121f", steel = "#8a8a8a", orange = "#d98c3f" }
  local set = vim.api.nvim_set_hl
  set(0, "SnacksDashboardHeader", { fg = p.gold_br, bold = true })
  set(0, "SnacksDashboardDesc", { fg = p.fg })
  set(0, "SnacksDashboardKey", { fg = p.red, bold = true })
  set(0, "SnacksDashboardIcon", { fg = p.gold })
  set(0, "SnacksDashboardFooter", { fg = p.steel, italic = true })
  set(0, "SnacksDashboardSpecial", { fg = p.orange, bold = true })
  set(0, "SnacksDashboardTitle", { fg = p.gold, bold = true })
end

return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, { callback = dorn_colors })
    end,
    opts = function(_, opts)
      opts.dashboard = {
        enabled = true,
        preset = {
          header = banner("FOR DORN"),
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
            { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
            { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
            { icon = " ", key = "c", desc = "Config", action = ":Telescope find_files cwd=" .. vim.fn.stdpath("config") },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { text = { { "⚔  FOR DORN AND THE EMPEROR  ⚔", hl = "SnacksDashboardSpecial" } }, align = "center", padding = 1 },
          { text = { { quote, hl = "SnacksDashboardFooter" } }, align = "center", padding = 1 },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      }
      opts.indent = { enabled = false } -- → indent-blankline
      opts.scroll = { enabled = false } -- smoother over WSL/zellij
      opts.notifier = { enabled = true, timeout = 3000 }
      opts.input = { enabled = true } -- replaces archived dressing.nvim input
      opts.words = { enabled = true }
      opts.bigfile = { enabled = true }
      opts.quickfile = { enabled = true }
      return opts
    end,
    keys = {
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit" },
      { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git browse (open in browser)" },
      { "<leader>.", function() require("snacks").scratch() end, desc = "Toggle scratch buffer" },
      { "<leader>S", function() require("snacks").scratch.select() end, desc = "Select scratch buffer" },
    },
  },
}
