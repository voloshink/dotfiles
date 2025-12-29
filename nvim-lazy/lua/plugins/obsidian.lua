return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian/personal-vault",
      },
    },

    notes_subdir = "notes/zk",
    new_notes_location = "notes_subdir",

    disable_frontmatter = true,
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S",
    },

    daily_notes = {
      folder = "notes/daily_notes",
      default_tags = { "daily-notes" },
      template = "note.md",
    },

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
  },
}
