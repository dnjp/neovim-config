local util = require('util')

vim.g.mapleader = ' '

--
-- convenience
--
util.map('n', ';', ':')
util.map('n', 'Q', ':q<CR>')
util.map('n', '<leader>k', ':noh<Enter>')
util.map('n', '<leader>r', ':source ~/.config/nvim/init.vim<Enter>')

--
-- navigation
--
util.map('n', '<C-J>', '<C-W><C-J>')
util.map('n', '<C-K>', '<C-W><C-K>')
util.map('n', '<C-L>', '<C-W><C-L>')
util.map('n', '<C-H>', '<C-W><C-H>')

--
-- searching
--
util.map('n', '<C-F>', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
util.map('n', '<C-G>', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
util.map('n', '<C-P>', '<cmd>lua require(\'telescope.builtin\').git_files()<cr>')
util.map('n', '<C-B>', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')

--
-- buffer management
--
util.map('n', '<A-]>', ':BufferLineCycleNext<CR>')
util.map('n', '<A-[>', ':BufferLineCyclePrev<CR>')

--
-- sidebar
--
util.map('n', '<A-b>', ':NvimTreeToggle<CR>')
util.map('n', '<A-r>', ':NvimTreeFindFile<CR>')

--
-- tmux
--
local opts = { noremap = true, silent = true }
util.map('n', "<A-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
util.map('n', "<A-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
util.map('n', "<A-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
util.map('n', "<A-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
util.map('n', "<A-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)

--
-- terminal
--
function _G.set_terminal_keymaps()
	local opts = {noremap = true}
	-- do not treat space key as leader
	vim.api.nvim_buf_set_keymap(0, 't', '<Space>', ' ', {noremap = true, nowait = true})
	vim.api.nvim_buf_set_keymap(0, 't', 'zz', [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-A-h>', [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-A-j>', [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-A-k>', [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, 't', '<C-A-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- use term://*toggleterm#* instead if this should just apply
-- to toggle term
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
	cmd = "zsh -c 'source ~/.zshrc && lazygit'",
	dir = "git_dir",
	hidden = true,
	direction = "horizontal",
	-- direction = "float",
	-- float_opts = {
	--   border = "double",
	-- },
	insert_mappings = false,
	on_open = function(term)
	  vim.cmd ':resize 40'
	  vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
	end,
	on_close = function(term)
	  vim.cmd ':resize 15'
	end,
})

function _lazygit_toggle()
	lazygit:toggle()
end

-- lazygit
vim.api.nvim_set_keymap("n", "<leader>s", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
util.map('n', "<C-A-\\>", ":ToggleTermToggleAll<CR>", opts)
-- list active terminals
util.map('n', "<C-A-l>", ":Telescope termfinder find<CR>")

--
-- Tmux
--
util.map('n', '<leader>T', ':Telescope tmux windows<CR>', {silent=true})

--
-- Project Management
--
vim.api.nvim_set_keymap(
    'n',
    '<C-A-p>',
    ":lua require'telescope'.extensions.project.project{display_type='full'}<CR>",
    {noremap = true, silent = true}
)

--
-- Task Runners
--
util.map('n', '<Leader>R', ':VimuxPromptCommand<CR>')
util.map('n', '<Leader>rg', ':VimuxPromptCommand("go ")<CR>')
util.map('n', '<Leader>rm', ':VimuxPromptCommand("make ")<CR>')
util.map('n', '<Leader>rr', ':VimuxRunLastCommand<CR>')
util.map('n', '<Leader>ri', ':VimuxInspectRunner<CR>')
util.map('n', '<Leader>rc', ':VimuxCloseRunner<CR>')

