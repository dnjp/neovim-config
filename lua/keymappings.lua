local util = require('util')

vim.g.mapleader = ' '

--
-- convenience
--
util.map('n', ';', ':')
util.map('n', 'Q', ':q<CR>')
util.map('n', '<leader>k', ':noh<CR>')
util.map('n', '<leader>l', ':b #<CR>')
util.map('n', '<leader>T', ':lua load_theme()<CR>')
util.map('n', '<C-Q>', ':BufDel<CR>')

--
-- navigation
--
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
vim.api.nvim_set_keymap('n', "<C-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)

--
-- searching
--
vim.api.nvim_set_keymap('n', '<C-F>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-G>',
    "<cmd>lua require('fzf-lua').live_grep_native()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-P>',
    "<cmd>lua require('fzf-lua').git_files()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-B>',
    "<cmd>lua require('fzf-lua').buffers()<CR>",
    { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<space>gs',
    "<cmd>lua require('fzf-lua').git_status()<CR>",
    { noremap = true, silent = true })

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

--
-- Text Movement
--
vim.g.move_map_keys = 0
vim.cmd [[vmap <A-Down> <Plug>MoveBlockDown]]
vim.cmd [[vmap <A-Up> <Plug>MoveBlockUp]]
vim.cmd [[vmap <A-Left> <Plug>MoveBlockLeft]]
vim.cmd [[vmap <A-Right> <Plug>MoveBlockRight]]
vim.cmd [[nmap <A-Down> <Plug>MoveLineDown]]
vim.cmd [[nmap <A-Up> <Plug>MoveLineUp]]
vim.cmd [[nmap <A-Left> <Plug>MoveCharLeft]]
vim.cmd [[nmap <A-Right> <Plug>MoveCharRight]]

--
-- Go
--
vim.cmd [[autocmd FileType go nmap <Leader><Leader>l GoLint]]
vim.cmd [[autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()]]
vim.cmd [[autocmd FileType go nmap <Leader>gdt :GoDebug test<CR>]]
vim.cmd [[autocmd FileType go nmap <Leader>gdf :GoDebug file<CR>]]
vim.cmd [[autocmd FileType go nmap <Leader>gdd :GoDebug nearest<CR>]]
vim.cmd [[autocmd FileType go nmap <Leader>gt :GoTest<CR>]]

