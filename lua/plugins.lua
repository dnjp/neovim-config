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

	-- go
	use 'ray-x/go.nvim'

	-- terraform
	use 'hashivim/vim-terraform'

	-- lsp
	use 'neovim/nvim-lspconfig'
	use {
		'williamboman/nvim-lsp-installer',
		requires = {
			'neovim/nvim-lspconfig',
		},
	}
	-- debugger adapter protocol (dap)
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use {
		'theHamsta/nvim-dap-virtual-text',
		requires = {
			'nvim-treesitter/nvim-treesitter',
			'mfussenegger/nvim-dap',
		},
	}
	use 'nvim-telescope/telescope-dap.nvim'
	use 'Pocco81/DAPInstall.nvim'

	-- completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lua'
	-- vs code like completion candidate icons
	use 'onsails/lspkind-nvim'
	-- signatures
	use 'ray-x/lsp_signature.nvim'

	-- snippets
	use "rafamadriz/friendly-snippets"
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	-- ui
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/popup.nvim'
	---- themes
	use 'EdenEast/nightfox.nvim'
	use 'chriskempson/base16-vim'

	---- file tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
	}


	-- commenting
	use {
		'numToStr/Comment.nvim',
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
	use {'pwntester/octo.nvim', config=function()
		require"octo".setup()
	end}
	use 'whiteinge/diffconflicts'

	-- ease of use
	use {
		'folke/which-key.nvim',
		config = function()
			require('which-key').setup{}
		end
	}
	-- make it easy to work with super user owned files
	use 'lambdalisue/suda.vim'
	-- various minimal tools
	use 'nvim-lualine/lualine.nvim'
	-- used by various plugins
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}
	-- automatically detect indentation
	use 'tpope/vim-sleuth'

	--
	-- Editing behavior
	--
	use 'windwp/nvim-autopairs'
	use 'matze/vim-move'
	use {
		"blackCauldron7/surround.nvim",
		config = function()
			require"surround".setup {mappings_style = "sandwich"}
		end
	}

	-- terminal
	use {'akinsho/toggleterm.nvim'}

	-- telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim',
		}
	}
	use 'camgraff/telescope-tmux.nvim'
	use {
		'tknightz/telescope-termfinder.nvim',
		requires = {
			'akinsho/toggleterm.nvim',
			'nvim-telescope/telescope.nvim'
		},
	}
	use 'nvim-telescope/telescope-project.nvim'

	-- tmux
	use {
		'numToStr/Navigator.nvim',
		config = function()
			require('Navigator').setup()
		end
	}
	use 'preservim/vimux'

	if packer_bootstrap then
		require('packer').sync()
	end
end
)

