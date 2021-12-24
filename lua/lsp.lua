local util = require('util')
local lspconfig = require('lspconfig')
local saga = require('lspsaga')
local nvim_lsp = require('cmp_nvim_lsp')

require('go').setup()

-- Format on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)

-- Import on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

-- go.config.update_tool('quicktype', function(tool)
--     tool.pkg_mgr = 'npm'
-- end)

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua require(\'telescope.builtin\').lsp_definitions(require(\'telescope.themes\').get_dropdown({}))<cr>', opts)
	-- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	-- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua require(\'telescope.builtin\').lsp_implementations(require(\'telescope.themes\').get_dropdown({}))<cr>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<leader>ca', '<cmd>lua require(\'telescope.builtin\').lsp_code_actions(require(\'telescope.themes\').get_cursor({}))<cr>', opts)
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua require(\'telescope.builtin\').lsp_references(require(\'telescope.themes\').get_ivy({}))<cr>', opts)
	-- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '<leader>d', '<cmd>lua require(\'telescope.builtin\').diagnostics(require(\'telescope.themes\').get_dropdown({}))<cr>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- go.setup({
--     -- auto commands
--     auto_format = true,
--     auto_lint = true, -- TODO: figure out how to do this in a less intrusive way
--     -- linters: revive, errcheck, staticcheck, golangci-lint
--     linter = 'staticcheck',
--     -- lint_prompt_style: qf (quickfix), vt (virtual text)
--     lint_prompt_style = 'qf',
--     -- formatter: goimports, gofmt, gofumpt
--     formatter = 'goimports',
--     -- test flags: -count=1 will disable cache
--     test_flags = {'-v'},
--     test_timeout = '30s',
--     test_env = {},
--     -- show test result with popup window
--     test_popup = true,
--     test_popup_width = 80,
--     test_popup_height = 10,
--     -- test open
--     test_open_cmd = 'edit',
--     -- struct tags
--     tags_name = 'json',
--     tags_options = {'json=omitempty'},
--     tags_transform = 'snakecase',
--     tags_flags = {'-skip-unexported'},
--     -- quick type
--     quick_type_flags = {'--just-types'},
-- })
--
lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},

	cmd = {"gopls", "serve"},
	-- settings = {
	-- 	gopls = {
	-- 		analyses = {
	-- 			unusedparams = true,
	-- 		},
	-- 		staticcheck = true,
	-- 	},
	-- },
})

-- lspsaga.init_lsp_saga()

saga.init_lsp_saga {
-- add your config value here
-- default value
	use_saga_diagnostic_sign = true,
-- error_sign = '',
-- warn_sign = '',
-- hint_sign = '',
-- infor_sign = '',
-- dianostic_header_icon = '   ',
-- code_action_icon = ' ',
	code_action_prompt = {
		enable = true,
		sign = true,
		sign_priority = 20,
		virtual_text = true,
	},
-- finder_definition_icon = '  ',
-- finder_reference_icon = '  ',
	max_preview_lines = 50, -- preview lines of lsp_finder and definition preview
	finder_action_keys = {
		open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
	},
	code_action_keys = {
		quit = 'q',exec = '<CR>'
	},
	rename_action_keys = {
		quit = '<C-c>',exec = '<CR>'  -- quit can be a table
	},
-- definition_preview_icon = '  '
-- "single" "double" "round" "plus"
-- border_style = "single"
-- rename_prompt_prefix = '➤',
-- if you don't use nvim-lspconfig you must pass your server name and
-- the related filetypes into this table
-- like server_filetype_map = {metals = {'sbt', 'scala'}}
-- server_filetype_map = {}
}

util.map('n', 'gh', '<cmd>lua require\'lspsaga.provider\'.lsp_finder()<CR>')

-- nnoremap <silent><leader>clf :Lspsaga lsp_finder<CR>
-- nnoremap <silent><leader>cca :Lspsaga code_action<CR>
-- vnoremap <silent><leader>cca :<C-U>Lspsaga range_code_action<CR>
-- nnoremap <silent><leader>chd :Lspsaga hover_doc<CR>
-- nnoremap <silent><C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
-- nnoremap <silent><C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
-- nnoremap <silent><leader>csh :Lspsaga signature_help<CR>
-- nnoremap <silent><leader>crn :Lspsaga rename<CR>
-- nnoremap <silent><leader>cpd:Lspsaga preview_definition<CR>
-- nnoremap <silent> <leader>cld :Lspsaga show_line_diagnostics<CR>
-- nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
-- nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
-- nnoremap <silent> <leader>cot :Lspsaga open_floaterm<CR>
-- tnoremap <silent> <leader>cct <C-\><C-n>:Lspsaga close_floaterm<CR>
