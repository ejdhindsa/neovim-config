-- Throttle Mason so the first-launch install of all the LSP servers doesn't
-- spawn ~10 concurrent npm/pip installs at once. On WSL that install storm can
-- spike the VM hard enough to stall it; 2-at-a-time keeps first launch smooth.
return {
  {
    "mason-org/mason.nvim",
    opts = {
      max_concurrent_installers = 2,
    },
  },
}
