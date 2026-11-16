-- there's no neotest adapter for cypress, run it through overseer

return {
  {
    "nvim-neotest/neotest",
    dependencies = { "marilari88/neotest-vitest" },
    opts = {
      adapters = {
        ["neotest-vitest"] = {},
      },
    },
  },
}
