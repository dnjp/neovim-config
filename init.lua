-- Auto install packer.nvim if not exists
-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--   vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
-- end

vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('settings')

require('plugins')

require('easy')

require('search')

require('completion')

require('lsp')

require('status')

require('theme')

require('tree')

require('commenting')

require('git')

require('shell')

require('keymappings')
