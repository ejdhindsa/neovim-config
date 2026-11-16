return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "debugloop/telescope-undo.nvim" },
    keys = {
      {
        "<leader>fu",
        function()
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
