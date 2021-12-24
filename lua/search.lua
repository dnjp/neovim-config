local ts = require('telescope')

ts.load_extension("termfinder")
ts.load_extension('fzy_native')
-- ts.load_extension('lsp_handlers')

ts.setup{
	defaults = {
		layout_config = {
			vertical = { width = 0.9 },
			horizontal = { width = 0.9 },
		},
	},
	extensions = {
		termfinder = {
			mappings = {
				rename_term = '<C-r>',
				delete_term = '<C-x>',
				vertical_term = '<C-v>',
				horizontal_term = '<C-h>',
				float_term = '<C-f>'
			},
		},
		-- lsp_handlers = {
		-- 	-- disable = {},
		-- 	location = {
		-- 		-- telescope = {},
		-- 		telescope = require('telescope.themes').get_ivy({}),
		-- 		no_results_message = 'No references found',
		-- 	},
		-- 	symbol = {
		-- 		-- telescope = {},
		-- 		telescope = require('telescope.themes').get_ivy({}),
		-- 		no_results_message = 'No symbols found',
		-- 	},
		-- 	call_hierarchy = {
		-- 		telescope = {},
		-- 		no_results_message = 'No calls found',
		-- 	},
		-- 	code_action = {
		-- 		telescope = require('telescope.themes').get_dropdown({}),
		-- 		no_results_message = 'No code actions available',
		-- 		prefix = '',
		-- 	},
		-- },
	},
}

