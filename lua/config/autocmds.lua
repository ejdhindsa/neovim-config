local augroup = vim.api.nvim_create_augroup

-- don't continue comments on o/O
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_auto_comment_o", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

vim.filetype.add({
  extension = {
    env = "sh",
  },
  filename = {
    [".env"] = "sh",
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
})

-- lazyvim only runs checktime on focus/terminal events, and switching zellij
-- panes doesn't fire those, so files changed from another pane never reloaded
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave", "TermClose" }, {
  group = augroup("checktime_external", { clear = true }),
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- autosave every minute
local autosave_timer = vim.uv.new_timer()
autosave_timer:start(60000, 60000, function()
  vim.schedule(function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if
        vim.api.nvim_buf_is_loaded(buf)
        and vim.bo[buf].modified
        and vim.bo[buf].buftype == ""
        and vim.api.nvim_buf_get_name(buf) ~= ""
      then
        vim.api.nvim_buf_call(buf, function()
          vim.cmd("silent! write")
        end)
      end
    end
  end)
end)
