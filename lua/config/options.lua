-- wsl clipboard: win32yank if it's installed, otherwise osc52 to copy and
-- powershell to paste
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
      -- powershell adds \r to every line
      ["+"] = [[powershell.exe -NoLogo -NoProfile -Command Get-Clipboard | tr -d '\r']],
      ["*"] = [[powershell.exe -NoLogo -NoProfile -Command Get-Clipboard | tr -d '\r']],
    },
    cache_enabled = 0,
  }
end

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = false
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 8
vim.opt.confirm = true
vim.opt.spelllang = { "en_us" }
vim.opt.timeoutlen = 400
vim.opt.updatetime = 200

vim.opt.fillchars:append({ eob = " " })

-- format on save kept reformatting code I didn't touch. <leader>cf instead
-- (in visual mode it only formats the selection)
vim.g.autoformat = false
