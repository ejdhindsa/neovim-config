-- Colorscheme library + theme picker.
-- "The more the merrier" — all lazy-loaded, browse them live with <leader>th.
-- BlackFox (your Zed theme) will be ported into lua/blackfox.lua once you hand
-- over the theme JSON; until then the default is tokyonight-night as a stand-in.

return {
  -- ── Theme engine / porting tool ──────────────────────────────────────
  { "rktjmp/lush.nvim", lazy = true }, -- for the faithful BlackFox port

  -- ── The library (all high-quality + easy to customize) ───────────────
  { "folke/tokyonight.nvim", lazy = true, opts = { style = "night" } },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "neanias/everforest-nvim", name = "everforest", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true }, -- nightfox/duskfox/carbonfox/...
  { "nyoom-engineering/oxocarbon.nvim", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "navarasu/onedark.nvim", lazy = true },
  { "olimorris/onedarkpro.nvim", lazy = true },
  { "miikanissi/modus-themes.nvim", lazy = true },
  { "Mofiqul/dracula.nvim", lazy = true },
  { "Mofiqul/vscode.nvim", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },
  { "marko-cerovac/material.nvim", lazy = true },
  { "ribru17/bamboo.nvim", lazy = true },

  -- ── Active colorscheme: BlackFox (ported from your Zed theme) ────────
  -- Lives in colors/blackfox.lua. The alternates above stay installed for
  -- browsing via <leader>th.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "blackfox",
    },
  },

  -- ── <leader>th → live theme picker with preview (home muscle-memory) ─
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>th",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Theme picker (preview)",
      },
    },
  },
}
