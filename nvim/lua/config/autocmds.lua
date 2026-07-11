-- Loaded automatically by LazyVim. LazyVim already provides highlight-on-yank,
-- resize-splits, close-with-q for helper buffers, etc. Add personal ones here.

local augroup = vim.api.nvim_create_augroup

-- Don't auto-continue comment leaders when pressing `o`/`O` on a comment line.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_auto_comment_o", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

-- Treat some extra extensions the way you'd expect for your stack.
vim.filetype.add({
  extension = {
    env = "sh", -- .env files: highlight as shell
  },
  filename = {
    [".env"] = "sh",
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
})
