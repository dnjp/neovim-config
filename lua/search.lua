local ts = require('telescope')

ts.load_extension('dap')
ts.load_extension("termfinder")
ts.load_extension('fzy_native')
ts.load_extension('tmux')

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
	},
}

