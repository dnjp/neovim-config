vim.g.gitgutter_set_sign_backgrounds = 1
vim.cmd 'let base16colorspace=256'
vim.cmd[[
	if filereadable(expand("~/.vimrc_background"))
		source ~/.vimrc_background
		highlight SignColumn guibg=bg
		highlight LineNr guibg=bg
	endif
]]

