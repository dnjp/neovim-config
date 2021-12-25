-- vim.cmd 'let base16colorspace=256'

-- vim.cmd[[
-- 	if filereadable(expand("~/.vimrc_background"))
-- 		source ~/.vimrc_background
-- 	endif
-- ]]

local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
nightfox.setup({
	fox = "nordfox", -- change the colorscheme to use nordfox
	terminal_colors = true,
})

-- Load the configuration set above and apply the colorscheme
nightfox.load()
