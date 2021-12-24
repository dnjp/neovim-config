-- Lua:
-- For dark theme
-- vim.g.vscode_style = "dark"
-- For light theme
-- vim.g.vscode_style = "light"
-- vim.cmd[[colorscheme vscode]]

-- require("bufferline").setup{}

-- vim.cmd[[colorscheme monochrome]]
-- vim.cmd[[colorscheme nord]]

vim.cmd 'let base16colorspace=256'

vim.cmd[[
	if filereadable(expand("~/.vimrc_background"))
		source ~/.vimrc_background
		highlight SignColumn guibg=bg
		highlight LineNr guibg=bg
	endif
]]

