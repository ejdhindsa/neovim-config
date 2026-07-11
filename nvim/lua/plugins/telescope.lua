-- Telescope is wired as the picker backend by the editor.telescope extra
-- (with fzf-native for speed). Here we just bolt on undo-history browsing.
-- Core keys from Zed muscle-memory already map via LazyVim:
--   <leader><space> / <leader>ff  → find files      (Zed's Cmd+P)
--   <leader>/       / <leader>sg  → live grep        (Zed's Cmd+Shift+F)
--   <leader>,                     → switch buffers

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "debugloop/telescope-undo.nvim" },
    keys = {
      {
        "<leader>fu",
        function()
          -- load_extension is idempotent and telescope is fully set up by now
          require("telescope").load_extension("undo")
          require("telescope").extensions.undo.undo()
        end,
        desc = "Undo history",
      },
    },
    opts = function(_, opts)
      opts.extensions = opts.extensions or {}
      opts.extensions.undo = {
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = { preview_height = 0.6 },
      }
    end,
  },
}
