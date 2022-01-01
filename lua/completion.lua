local cmp = require('cmp')
local lspkind = require('lspkind')
local ls = require('luasnip')
local types = require("luasnip.util.types")

ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "choiceNode", "Comment" } },
			},
		},
	},
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 300,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = true,
})

require('luasnip.loaders.from_vscode').load({
	paths = {
		'~/.local/share/nvim/site/pack/packer/start/friendly-snippets',
		vim.fn.stdpath('config')..'/snippets'
	}
})

-- require'nvim-treesitter.configs'.setup {
-- 	-- One of "all", "maintained" (parsers with maintainers), or a list of languages
-- 	ensure_installed = "maintained",
-- 	sync_install = false,
-- 	highlight = { enable = false },
-- 	indent = { enable = false },
--
-- 	incremental_selection = {
-- 		enable = enable,
-- 		keymaps = {
-- 			-- mappings for incremental selection (visual mappings)
-- 			init_selection = "gnn", -- maps in normal mode to init the node/scope selection
-- 			node_incremental = "grn", -- increment to the upper named parent
-- 			scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
-- 			node_decremental = "grm" -- decrement to the previous node
-- 		}
-- 	},
-- 	textobjects = {
-- 		-- syntax-aware textobjects
-- 		enable = enable,
-- 		lsp_interop = {
-- 			enable = enable,
-- 			peek_definition_code = {
-- 				["DF"] = "@function.outer",
-- 				["DF"] = "@class.outer"
-- 			}
-- 		},
-- 		keymaps = {
-- 			["iL"] = {
-- 				-- you can define your own textobjects directly here
-- 				go = "(function_definition) @function",
-- 			},
-- 			-- or you use the queries from supported languages with textobjects.scm
-- 			["af"] = "@function.outer",
-- 			["if"] = "@function.inner",
-- 			["aC"] = "@class.outer",
-- 			["iC"] = "@class.inner",
-- 			["ac"] = "@conditional.outer",
-- 			["ic"] = "@conditional.inner",
-- 			["ae"] = "@block.outer",
-- 			["ie"] = "@block.inner",
-- 			["al"] = "@loop.outer",
-- 			["il"] = "@loop.inner",
-- 			["is"] = "@statement.inner",
-- 			["as"] = "@statement.outer",
-- 			["ad"] = "@comment.outer",
-- 			["am"] = "@call.outer",
-- 			["im"] = "@call.inner"
-- 		},
-- 		move = {
-- 			enable = enable,
-- 			set_jumps = true, -- whether to set jumps in the jumplist
-- 			goto_next_start = {
-- 				["]m"] = "@function.outer",
-- 				["]]"] = "@class.outer"
-- 			},
-- 			goto_next_end = {
-- 				["]M"] = "@function.outer",
-- 				["]["] = "@class.outer"
-- 			},
-- 			goto_previous_start = {
-- 				["[m"] = "@function.outer",
-- 				["[["] = "@class.outer"
-- 			},
-- 			goto_previous_end = {
-- 				["[M"] = "@function.outer",
-- 				["[]"] = "@class.outer"
-- 			}
-- 		},
-- 		select = {
-- 			enable = enable,
-- 			keymaps = {
-- 				-- You can use the capture groups defined in textobjects.scm
-- 				["af"] = "@function.outer",
-- 				["if"] = "@function.inner",
-- 				["ac"] = "@class.outer",
-- 				["ic"] = "@class.inner",
-- 				-- Or you can define your own textobjects like this
-- 				["iF"] = {
-- 					python = "(function_definition) @function",
-- 					cpp = "(function_definition) @function",
-- 					c = "(function_definition) @function",
-- 					java = "(method_declaration) @function",
-- 					go = "(method_declaration) @function"
-- 				}
-- 			}
-- 		},
-- 		swap = {
-- 			enable = enable,
-- 			swap_next = {
-- 				["<leader>a"] = "@parameter.inner"
-- 			},
-- 			swap_previous = {
-- 				["<leader>A"] = "@parameter.inner"
-- 			}
-- 		}
-- 	}
--
-- }

-- comment handling
require('Comment').setup()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

require('lspkind').init({
	-- enables text annotations
	--
	-- default: true
	with_text = true,

	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
	preset = 'default',
})

cmp.setup({
	completion = {
		autocomplete = false,
		completeopt = 'menu,menuone,noselect'
	},
	formatting = {
		fields = {
			cmp.ItemField.Abbr,
			cmp.ItemField.Kind,
			cmp.ItemField.Menu,
		},
		format = lspkind.cmp_format({
			with_text = true, -- whether to show text alongside icons
			maxwidth = 50,
		})
	},
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body)
			print(args)
			ls.lsp_expand(args.body)
		end,
	},
	mapping = {
	-- 	['<C-p>'] = cmp.mapping.select_prev_item(),
	-- 	['<C-n>'] = cmp.mapping.select_next_item(),
	-- 	['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
	-- 	['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
	-- 	['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
	-- 	['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
	-- 	['<C-e>'] = cmp.mapping({
	-- 		i = cmp.mapping.abort(),
	-- 		c = cmp.mapping.close(),
	-- 	}),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	-- 	-- ["<Tab>"] = cmp.mapping(function(fallback)
	-- 	-- 	if cmp.visible() then
	-- 	-- 		cmp.select_next_item()
	-- 	-- 	elseif ls.expand_or_jumpable() then
	-- 	-- 		ls.expand_or_jump()
	-- 	-- 	elseif has_words_before() then
	-- 	-- 		cmp.complete()
	-- 	-- 	else
	-- 	-- 		fallback()
	-- 	-- 	end
	-- 	-- end, { "i", "s" }),
	--
	-- 	-- ["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 	-- 	if cmp.visible() then
	-- 	-- 		cmp.select_prev_item()
	-- 	-- 	elseif ls.jumpable(-1) then
	-- 	-- 		ls.jump(-1)
	-- 	-- 	else
	-- 	-- 		fallback()
	-- 	-- 	end
	-- 	-- end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip', option = { use_show_condition = true } },
		{ name = 'path' },
		{ name = 'buffer' },
		-- { name = 'vsnip' },
	}, {
			{
				name = 'buffer',
				-- keyword_length = 5,
				-- option = {
				-- 	get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end
				-- }
			}
		})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
			{ name = 'cmdline' }
		})
})

--
-- use nvim-cmp as omnicomplete handler
--
_G.vimrc = _G.vimrc or {}
_G.vimrc.cmp = _G.vimrc.cmp or {}
_G.vimrc.cmp.lsp = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'nvim_lsp' }
      }
    }
  })
end
_G.vimrc.cmp.snippet = function()
  cmp.complete({
    config = {
      sources = {
        { name = 'vsnip' }
      }
    }
  })
end

vim.cmd([[
  inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
  inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>
]])
