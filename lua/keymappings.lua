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
util.map('n', '<C-A-b>', ':NvimTreeToggle<CR>')
util.map('n', '<leader>R', ':NvimTreeFindFile<CR>')

--
-- git
--
-- util.map('n', '<leader>s', ':Neogit<CR>')
util.map('n', '<leader>mt', '<plug>(MergetoolToggle)')
util.map('n', 'mh', ':MergetoolDiffExchangeLeft<CR>')
util.map('n', 'ml', ':MergetoolDiffExchangeRight<CR>')
util.map('n', 'mj', ':MergetoolDiffExchangeDown<CR>')
util.map('n', 'mk', ':MergetoolDiffExchangeUp<CR>')

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

util.map('n', "<C-A-\\>", ":ToggleTermToggleAll<CR>", opts)


util.map('n', "<C-A-l>", ":Telescope termfinder find<CR>")

--
-- Lspsaga
--
-- TODO: convert these to call lua functions instead of using ex commands
util.map('n', 'gr', '<cmd>lua require\'lspsaga.provider\'.lsp_finder()<CR>')
util.map('n', '<leader>ca', ':Lspsaga code_action<CR>', {silent=true})
util.map('n', 'K', ':Lspsaga hover_doc<CR>', {silent=true})
util.map('n', '<C-A-F>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(1)<CR>', {silent=true})
util.map('n', '<C-A-B>', '<cmd>lua require(\'lspsaga.action\').smart_scroll_with_saga(-1)<CR>', {silent=true})
util.map('n', '<leader>csh', ':Lspsaga signature_help<CR>', {silent=true})
util.map('n', '<leader>rn', ':Lspsaga rename<CR>', {silent=true})
util.map('n', 'gD', ':Lspsaga preview_definition<CR>', {silent=true})
util.map('n', '<leader>D', ':Lspsaga show_line_diagnostics<CR>', {silent=true})
util.map('n', '[e', ':Lspsaga diagnostic_jump_next<CR>', {silent=true})
util.map('n', ']e', ':Lspsaga diagnostic_jump_prev<CR>', {silent=true})
util.map('n', '<leader>cot', ':Lspsaga open_floaterm<CR>', {silent=true})
util.map('t', '<leader>cct', '<C-\\><C-n>:Lspsaga close_floaterm<CR>', {silent=true})
util.map('v', '<leader>cca', ':<C-U>Lspsaga range_code_action<CR>', {silent=true})

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
