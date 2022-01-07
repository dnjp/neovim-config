local util = require('util')
local lspconfig = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_path = require("nvim-lsp-installer.path")
local dap_install = require("dap-install")

local lsp_installer_dir = lsp_installer_path.concat {vim.fn.stdpath 'data', 'lsp_servers'}
local lsp_installer_servers = require'nvim-lsp-installer.servers'

--
-- DAP
--
dap_install.config("go_delve", {})
require("dapui").setup()

require("nvim-dap-virtual-text").setup()
require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require('go').setup({
	goimport='gopls', -- goimport command, can be gopls[default] or goimport
	-- gofmt = 'gofumpt', --gofmt cmd,
	gofmt = 'gofmt', --gofmt cmd,
	max_line_len = 120, -- max line length in goline format
	tag_transform = false, -- tag_transfer  check gomodifytags for details
	comment_placeholder = '' ,  -- comment_placeholder your cool placeholder e.g. ﳑ       
	icons = {breakpoint = '', currentpos = ''},
	verbose = false,  -- output loginf in messages
	lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
	                 -- false: do nothing
	                 -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
	                 --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
	lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
	lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
	                     --      when lsp_cfg is true
	                     -- if lsp_on_attach is a function: use this function as on_attach function for gopls
	lsp_codelens = true, -- set to false to disable codelens, true by default
	gopls_remote_auto = true, -- add -remote=auto to gopls
	-- gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
	gopls_cmd = {lsp_installer_dir .. '/go/gopls'},
	fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls
	lsp_diag_hdlr = true, -- hook lsp diag handler
	dap_debug = true, -- set to false to disable dap
	textobjects = false, -- enable default text jobects through treesittter-text-objects
	test_runner = 'go', -- richgo, go test, richgo, dlv, ginkgo
	run_in_floaterm = false, -- set to true to run in float window.
	--float term recommand if you use richgo/ginkgo with terminal color
	dap_debug_keymap = true, -- set keymaps for debugger
	dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
	dap_debug_vt = true, -- set to true to enable dap virtual text
	build_tags = "integration" -- set default build tags
})

-- Format on save
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)

-- Import on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua require(\'fzf-lua\').lsp_code_actions()<CR>', opts)
	buf_set_keymap('n', '<space>fs', '<cmd>lua require(\'fzf-lua\').lsp_document_symbols()<CR>', opts)

	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '<space>d', '<cmd>lua require(\'fzf-lua\').lsp_document_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

--
-- UI Tweaks
-- See: https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
--

-- disable inline diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
    }
)

-- show diagnostics in hover window instead of inline
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- show diagnostics in message area instead of inline
-- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--   opts = opts or {}
--
--   bufnr = bufnr or 0
--   line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
--
--   local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
--   if vim.tbl_isempty(line_diagnostics) then return end
--
--   local diagnostic_message = ""
--   for i, diagnostic in ipairs(line_diagnostics) do
--     diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--     print(diagnostic_message)
--     if i ~= #line_diagnostics then
--       diagnostic_message = diagnostic_message .. "\n"
--     end
--   end
--   vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
-- end
-- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--
--
-- Language Servers
--
--
lsp_installer.on_server_ready(function(server)
	local default_opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		}
	}

	local server_opts = {
		-- Provide settings that should only apply to the specified server
		["jdtls"] = function()
			default_opts.root_dir = function(fname)
				return lspconfig.util.root_pattern('pom.xml', 'gradle.build', '.git')(fname) or vim.fn.getcwd()
			end
		end,
		["gopls"] = function()
			default_opts.settings = {
				gopls = {
					buildFlags =  {"-tags=integration"},
					templateExtensions = {},
				},
			}
		end,
	}
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	-- Use the server's custom settings, if they exist, otherwise default to the default options
	local server_options = server_opts[server.name] and server_opts[server.name]() or default_opts
	server:setup(server_options)
end)


