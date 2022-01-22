local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

return require('packer').startup(function(use)
	-- let packer manage itself
	use 'wbthomason/packer.nvim'

	--
	-- Languages
	--

	-- go
	use 'ray-x/go.nvim'

	-- terraform
	use 'hashivim/vim-terraform'

	--
	-- lsp
	--
	use 'neovim/nvim-lspconfig'
	use {
		'williamboman/nvim-lsp-installer',
		requires = {
			'neovim/nvim-lspconfig',
		},
	}
	use 'ncm2/float-preview.nvim'
	use 'ray-x/lsp_signature.nvim'

	-- completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	---- themes
	use 'chriskempson/base16-vim'
	use 'pbrisbin/vim-colors-off'

	---- file tree
	use {
		'kyazdani42/nvim-tree.lua',
	}

	--
	-- searching
	--
	use { 'ibhagwan/fzf-lua',
	}

	--
	-- git
	--
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
	}

	-- make it easy to work with super user owned files
	use 'lambdalisue/suda.vim'
	-- automatically detect indentation
	use 'tpope/vim-sleuth'

	--
	-- Editing behavior
	--
	use 'matze/vim-move' -- allows moving lines up/down
	use 'ojroques/nvim-bufdel' -- better buffer deletion

	-- commenting
	use {
		'numToStr/Comment.nvim',
	}

	--
	-- tmux
	--
	use {
		'numToStr/Navigator.nvim',
		config = function()
			require('Navigator').setup()
		end
	}

	--
	-- shell
	--
	use 'nanotee/zoxide.vim'

	if packer_bootstrap then
		require('packer').sync()
	end
end
)

