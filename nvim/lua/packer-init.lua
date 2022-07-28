-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocommand to run :PackerSync whenever this file is updated
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = 'packer-init.lua',
    group = vim.api.nvim_create_augroup('packer_user_config', {clear = true}),
    callback = function()
        vim.cmd('source <afile>')
        vim.cmd('PackerSync')
    end
})

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use 'folke/tokyonight.nvim'
    -- Collection of configurations for the built-in LSP client
    use 'neovim/nvim-lspconfig'
    -- Autocomplete UI
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'saadparwaiz1/cmp_luasnip',
        },
    }

    -- Fuzzy selector
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
    }
    -- Treesitter for fancy syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }

    -- LSP progress indicator
    use {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup()
        end
    }
    -- Comment / uncomment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- highlighting whitespace
    use {
        'ntpeters/vim-better-whitespace'
    }
end)
