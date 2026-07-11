-- Testing. neotest core comes from the test.core extra; add the Vitest adapter.
-- Keys live under <leader>t (LazyVim's test group):
--   <leader>tr run nearest · <leader>tt run file · <leader>ts summary ·
--   <leader>to output · <leader>tS stop
--
-- Note: Cypress has no first-class neotest adapter — run e2e via Overseer
-- (<leader>or) or a terminal instead.

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
