-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- ═══════════════════════════════════════════════════════════════════
    -- LazyVim core + its sensible defaults (LSP, treesitter, gitsigns, ...)
    -- We treat this purely as scaffolding and override freely below.
    -- ═══════════════════════════════════════════════════════════════════
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- ── LazyVim Extras ─────────────────────────────────────────────────
    -- Editor / coding
    { import = "lazyvim.plugins.extras.editor.telescope" }, -- Telescope as picker backend (+ fzf-native)
    { import = "lazyvim.plugins.extras.coding.mini-surround" }, -- mini.surround
    { import = "lazyvim.plugins.extras.coding.yanky" }, -- yanky (yank ring + history)
    { import = "lazyvim.plugins.extras.ai.copilot" }, -- Copilot ghost-text (rides your Copilot sub)
    { import = "lazyvim.plugins.extras.test.core" }, -- neotest core (adapter added in plugins/testing.lua)
    { import = "lazyvim.plugins.extras.formatting.prettier" }, -- Prettier via conform

    -- Languages (Vue extra pulls in lang.typescript automatically → vtsls also powers plain JS)
    { import = "lazyvim.plugins.extras.lang.vue" }, -- vue_ls + vtsls hybrid mode
    { import = "lazyvim.plugins.extras.lang.json" }, -- jsonls + SchemaStore
    { import = "lazyvim.plugins.extras.lang.docker" }, -- dockerls + compose + yaml
    { import = "lazyvim.plugins.extras.lang.markdown" }, -- marksman + markdownlint + render-markdown
    { import = "lazyvim.plugins.extras.lang.rust" }, -- rustaceanvim + crates.nvim
    { import = "lazyvim.plugins.extras.lang.clangd" }, -- clangd + clangd_extensions
    { import = "lazyvim.plugins.extras.lang.sql" }, -- vim-dadbod + dadbod-ui + dadbod-completion

    -- ── Your own specs (these win over everything above) ───────────────
    { import = "plugins" },
  },
  defaults = {
    -- Our own plugin specs are loaded eagerly unless they set lazy=true;
    -- extras/LazyVim manage their own lazy-loading.
    lazy = false,
    version = false, -- always use latest git (LazyVim recommendation)
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false }, -- background update checks, no nag
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
