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

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- go
	use 'nvim-lua/plenary.nvim'
	use 'nvim-lua/popup.nvim'
	-- use 'crispgm/nvim-go'
	use 'ray-x/go.nvim'

	-- lsp
	use 'neovim/nvim-lspconfig'
	use 'tami5/lspsaga.nvim'
	-- completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lua'
	-- vs code like completion candidate icons
	use 'onsails/lspkind-nvim'

	-- snippets
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	-- ui
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}
	---- themes
	use 'kdheepak/monochrome.nvim'
	use 'shaunsingh/nord.nvim'
	use 'chriskempson/base16-vim'

	---- file tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
	}

	-- searching
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim',
			-- 'gbrlsnchs/telescope-lsp-handlers.nvim',
		}
	}

	-- commenting
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-- git
	use {
		'TimUntersberger/neogit',
		requires = {
		  'nvim-lua/plenary.nvim',
		  'sindrets/diffview.nvim'
		},
	}
	use 'airblade/vim-gitgutter'
	use 'samoshkin/vim-mergetool'

	-- ease of use
	use {
		'folke/which-key.nvim',
		config = function()
			require('which-key').setup {
			  -- your configuration comes here
			  -- or leave it empty to use the default settings
			  -- refer to the configuration section below
			}
		end
	}
	-- use {
	-- 	'windwp/nvim-autopairs',
	-- 	config = function()
	-- 		require('nvim-autopairs').setup{}
	-- 	end
	-- }
	use 'wsdjeg/vim-fetch' -- use standard unix format for opening files: i.e. vi ${file}:${line}:${column}
	use 'lambdalisue/suda.vim' -- make it easy to work with super user owned files
	use {
		'echasnovski/mini.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
			'lewis6991/gitsigns.nvim',
			'nvim-lua/plenary.nvim',
		},
	}

	-- terminal
	use {'akinsho/toggleterm.nvim'}
	use {
		'tknightz/telescope-termfinder.nvim',
		requires = {
			'akinsho/toggleterm.nvim',
			'nvim-telescope/telescope.nvim'
		},
	}

	-- remote development
	-- TODO
	-- use 'jamestthompson3/nvim-remote-containers' -- https://github.com/jamestthompson3/nvim-remote-containers

	-- tmux
	use {
	    'numToStr/Navigator.nvim',
	    config = function()
		require('Navigator').setup()
	    end
	}

	if packer_bootstrap then
		require('packer').sync()
	end
	end
)

