local util = require('util')

vim.g.mapleader = ' '

-- convenience
util.map('n', ';', ':')
util.map('n', 'Q', ':q<CR>')
util.map('n', '<leader>k', ':noh<Enter>')
util.map('n', '<leader>r', ':source ~/.config/nvim/init.vim<Enter>')

-- navigation
util.map('n', '<C-J>', '<C-W><C-J>')
util.map('n', '<C-K>', '<C-W><C-K>')
util.map('n', '<C-L>', '<C-W><C-L>')
util.map('n', '<C-H>', '<C-W><C-H>')

-- searching
util.map('n', '<C-F>', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
util.map('n', '<C-G>', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
util.map('n', '<C-P>', '<cmd>lua require(\'telescope.builtin\').git_files()<cr>')
util.map('n', '<C-B>', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')

-- buffer management
util.map('n', '<A-]>', ':BufferLineCycleNext<CR>')
util.map('n', '<A-[>', ':BufferLineCyclePrev<CR>')

-- sidebar
util.map('n', '<C-A-b>', ':NvimTreeToggle<CR>')
util.map('n', '<leader>R', ':NvimTreeFindFile<CR>')

-- git
-- util.map('n', '<leader>s', ':Neogit<CR>')
util.map('n', '<leader>mt', '<plug>(MergetoolToggle)')
util.map('n', 'mh', ':MergetoolDiffExchangeLeft<CR>')
util.map('n', 'ml', ':MergetoolDiffExchangeRight<CR>')
util.map('n', 'mj', ':MergetoolDiffExchangeDown<CR>')
util.map('n', 'mk', ':MergetoolDiffExchangeUp<CR>')

-- tmux
local opts = { noremap = true, silent = true }
util.map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
util.map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
util.map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
util.map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
util.map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)

-- terminal
function _G.set_terminal_keymaps()
	local opts = {noremap = true}
	-- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', 'zz', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal
-- local lazygit = Terminal:new({ 
-- 	cmd = "lazygit", 
-- 	direction = 'float',
-- 	hidden = true 
-- })

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	hidden = true,
	direction = "float",
	float_opts = {
	  border = "double",
	},
	insert_mappings = false,
	-- function to run on opening the terminal
	on_open = function(term)
	  -- vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
	  vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
	end,
	-- function to run on closing the terminal
	-- on_close = function(term)
	-- end,
})

function _lazygit_toggle()
	lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
-- util.map('n', "<C-\\>", ":ToggleTermToggleAll<CR>", opts)


util.map('n', "<C-A-l>", ":Telescope termfinder find<CR>")

