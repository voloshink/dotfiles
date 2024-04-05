return {
  {
    "mcchrish/zenbones.nvim",
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    name = "onedark",
    opts = {
      style = "warmer",
      transparent = true,
      lualine = {
        transparent = true,
      },
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zenbones",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "rktjmp/lush.nvim",
  },

  {
    "rasmus.nvim",
  },
  { "zaki/zazen" },
  { "hardselius/warlock" },
  { "p00f/alabaster.nvim", name = "alabaster" },
}
