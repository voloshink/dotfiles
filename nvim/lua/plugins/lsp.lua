return {
  "neovim/nvim-lspconfig",
  opts = {
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = {
      tsserver = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "relative",
            importModuleSpecifierEnding = "minimal",
          },
        },
      },
      ts_ls = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "relative",
            importModuleSpecifierEnding = "minimal",
          },
        },
      },
    },
  },
  -- config = function(_, opts)
  --   local lspconfig = require("lspconfig")
  --   lspconfig.sourcekit.setup({
  --     capabilities = {
  --       workspace = {
  --         didChangeWatchedFiles = {
  --           dynamicRegistration = true,
  --         },
  --       },
  --     },
  --   })
  -- end,
}
