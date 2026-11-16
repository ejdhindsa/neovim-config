-- installing every server at once on first launch was freezing wsl
return {
  {
    "mason-org/mason.nvim",
    opts = {
      max_concurrent_installers = 2,
    },
  },
}
