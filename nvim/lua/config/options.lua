-- Loaded automatically by LazyVim before lazy setup.
-- Most defaults come from LazyVim; keep this lean and personal.

-- ── WSL clipboard bridge ───────────────────────────────────────────────
-- You edit on the WSL filesystem, so nvim needs a bridge to the Windows
-- clipboard. Preference order:
--   1. win32yank.exe  → cleanest two-way sync, no CRLF junk  (RECOMMENDED — install it)
--   2. OSC52 (copy)   → works through zellij + a modern terminal, no binary
--      + powershell Get-Clipboard (paste, with CR stripped)
local function has(bin)
  return vim.fn.executable(bin) == 1
end

if has("win32yank.exe") then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
elseif has("clip.exe") then
  local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "wsl-osc52+powershell",
    copy = {
      ["+"] = ok and osc52.copy("+") or "clip.exe",
      ["*"] = ok and osc52.copy("*") or "clip.exe",
    },
    paste = {
      -- strip the CR that powershell appends so pastes don't get ^M line endings
      ["+"] = [[powershell.exe -NoLogo -NoProfile -Command Get-Clipboard | tr -d '\r']],
      ["*"] = [[powershell.exe -NoLogo -NoProfile -Command Get-Clipboard | tr -d '\r']],
    },
    cache_enabled = 0,
  }
end

vim.opt.clipboard = "unnamedplus"

-- ── Personal editor defaults (tweak freely) ────────────────────────────
vim.opt.wrap = false
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 8
vim.opt.confirm = true -- ask to save instead of erroring on :q with changes
vim.opt.spelllang = { "en_us" }
vim.opt.timeoutlen = 400 -- snappier which-key
vim.opt.updatetime = 200

-- Nice fill/border characters (works great in a truecolor terminal)
vim.opt.fillchars:append({ eob = " " })
