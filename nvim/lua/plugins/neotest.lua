return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-jest",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = { "neotest-vitest", "neotest-jest" },
    },
  },
}
