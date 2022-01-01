-- vim.cmd 'let base16colorspace=256'

-- vim.cmd[[
-- 	if filereadable(expand("~/.vimrc_background"))
-- 		source ~/.vimrc_background
-- 	endif
-- ]]

-- local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
-- nightfox.setup({
-- 	fox = "nordfox", -- change the colorscheme to use nordfox
-- 	terminal_colors = true,
-- })

-- Load the configuration set above and apply the colorscheme
-- nightfox.load()

vim.cmd [[
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
]]

vim.cmd 'highlight SignColumn guibg=bg'
vim.cmd 'highlight LineNr guibg=bg'
vim.cmd [[execute 'highlight GitSignsChange guibg=bg guifg=#' . g:base16_gui0D]]
vim.cmd [[execute 'highlight GitSignsDelete guibg=bg guifg=#' . g:base16_gui08]]
vim.cmd [[execute 'highlight GitSignsAdd guibg=bg guifg=#' . g:base16_gui0B]]
vim.cmd [[execute 'highlight VertSplit guibg=none guifg=#' . g:base16_gui03]]
