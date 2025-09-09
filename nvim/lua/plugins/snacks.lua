return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = {
      git_status_open = true,
      diagnostics_open = true,
    },
    picker = {
      sources = {
        explorer = {},
      },
    },
  },
}
