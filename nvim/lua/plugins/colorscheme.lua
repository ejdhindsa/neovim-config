return {
  { "rktjmp/lush.nvim", lazy = true },

  { "folke/tokyonight.nvim", lazy = true, opts = { style = "night" } },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "neanias/everforest-nvim", name = "everforest", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
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

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "blackfox",
    },
  },

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
