-- Loaded automatically by LazyVim (on VeryLazy).
-- General, plugin-agnostic keymaps only. Plugin-specific keys live next to
-- their plugin spec in lua/plugins/* so they lazy-load correctly.

local map = vim.keymap.set

-- Keep the cursor centered on big jumps / search
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })

-- Keep visual selection when re-indenting
map("v", "<", "<gv", { desc = "Indent left (keep selection)" })
map("v", ">", ">gv", { desc = "Indent right (keep selection)" })

-- Move selected lines and auto-indent (mini.move also does this with Alt-hjkl)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Paste over a selection without clobbering the yank register
map("x", "<leader>p", [["_dP]], { desc = "Paste (keep register)" })

-- Explicit system-clipboard yank/delete
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete (void register)" })
