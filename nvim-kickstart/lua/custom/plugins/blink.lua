return {
	"saghen/blink.cmp",
	-- event = "VimEnter",
	event = { "InsertEnter", "CmdlineEnter" },
	version = "1.*",
	dependencies = {
		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				-- Build Step is needed for regex support in snippets.
				-- This step is not supported in many windows environments.
				-- Remove the below condition to re-enable on windows.
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				--    https://github.com/rafamadriz/friendly-snippets/wiki
				{
					-- "rafamadriz/friendly-snippets",
					-- config = function()
					-- 	require("luasnip.loaders.from_vscode").lazy_load()
					-- 	require("luasnip").filetype_extend("typescript", { "tsdoc" })
					-- 	require("luasnip").filetype_extend("javascript", { "jsdoc" })
					-- end,
				},
			},
			opts = {},
		},
		"folke/lazydev.nvim",
	},
	--- @module 'blink.cmp'
	--- @type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
			--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps

			-- In case i want to support enter for accepting completion
			--         preset = "enter",
			--         ["<C-y>"] = { "select_and_accept" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			-- By default, you may press `<c-space>` to show the documentation.
			-- Optionally, set `auto_show = true` to show the documentation after a delay.
			-- documentation = { auto_show = false, auto_show_delay_ms = 500 },

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},

			accept = {
				-- experimental auto-brackets support
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			ghost_text = {
				enabled = vim.g.ai_cmp,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets" },
			per_filetype = {
				lua = { inherit_defaults = true, "lazydev" },
			},
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- show at a higher priority than lsp
				},
			},
		},

		snippets = { preset = "luasnip" },

		fuzzy = { implementation = "prefer_rust_with_warning" },

		-- Shows a signature help window while you type arguments for a function
		signature = { enabled = true },

		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				-- ["<Tab>"] = { "show", "accept" },
				-- ["<CR>"] = { "accept_and_enter", "fallback" },
				["<Right>"] = false,
				["<Left>"] = false,
			},
			completion = {
				list = { selection = { preselect = false } },
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
					end,
				},
				ghost_text = { enabled = true },
			},
		},
	},
}

-- {
--   {
--     "saghen/blink.cmp",
--     opts_extend = {
--       "sources.completion.enabled_providers",
--       "sources.compat",
--       "sources.default",
--     },
--     ---@module 'blink.cmp'
--     ---@type blink.cmp.Config
--     opts = {
--       snippets = {
--         expand = function(snippet, _)
--           return LazyVim.cmp.expand(snippet)
--         end,
--       },
--     },
--     ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
--     config = function(_, opts)
--       -- setup compat sources
--       local enabled = opts.sources.default
--       for _, source in ipairs(opts.sources.compat or {}) do
--         opts.sources.providers[source] = vim.tbl_deep_extend(
--           "force",
--           { name = source, module = "blink.compat.source" },
--           opts.sources.providers[source] or {}
--         )
--         if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
--           table.insert(enabled, source)
--         end
--       end
--
--       -- add ai_accept to <Tab> key
--       if not opts.keymap["<Tab>"] then
--         if opts.keymap.preset == "super-tab" then -- super-tab
--           opts.keymap["<Tab>"] = {
--             require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
--             LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
--             "fallback",
--           }
--         else -- other presets
--           opts.keymap["<Tab>"] = {
--             LazyVim.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }),
--             "fallback",
--           }
--         end
--       end
--
--       -- Unset custom prop to pass blink.cmp validation
--       opts.sources.compat = nil
--
--       -- check if we need to override symbol kinds
--       for _, provider in pairs(opts.sources.providers or {}) do
--         ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
--         if provider.kind then
--           local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
--           local kind_idx = #CompletionItemKind + 1
--
--           CompletionItemKind[kind_idx] = provider.kind
--           ---@diagnostic disable-next-line: no-unknown
--           CompletionItemKind[provider.kind] = kind_idx
--
--           ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
--           local transform_items = provider.transform_items
--           ---@param ctx blink.cmp.Context
--           ---@param items blink.cmp.CompletionItem[]
--           provider.transform_items = function(ctx, items)
--             items = transform_items and transform_items(ctx, items) or items
--             for _, item in ipairs(items) do
--               item.kind = kind_idx or item.kind
--               item.kind_icon = LazyVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
--             end
--             return items
--           end
--
--           -- Unset custom prop to pass blink.cmp validation
--           provider.kind = nil
--         end
--       end
--
--       require("blink.cmp").setup(opts)
--     end,
--   },
--
--   -- add icons
--   {
--     "saghen/blink.cmp",
--     opts = function(_, opts)
--       opts.appearance = opts.appearance or {}
--       opts.appearance.kind_icons = vim.tbl_extend("force", opts.appearance.kind_icons or {}, LazyVim.config.icons.kinds)
--     end,
--   },
-- }
