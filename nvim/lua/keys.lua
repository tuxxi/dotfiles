vim.g.mapleader = ' '
vim.g.localleader = ' '

local opts = { noremap = true, silent = true }

-- key mappings
vim.keymap.set('n', '<Esc><Esc>', '<cmd>noh<cr>', opts) -- remove search highlight
vim.keymap.set('n', '<leader>d', '<cmd>bd!<cr>', opts) -- close current buffer

-- Telescope resumer based on state
-- https://github.com/nvim-telescope/telescope.nvim/issues/1701
local builtin = require('telescope.builtin')
_last_picker = nil
_last_ctx = nil
local function telescope_middleware(func, ctxfunc)
  function inner()
    if ctxfunc == nil then
      ctx = nil
    else
      ctx = ctxfunc()
    end
    if func == _last_picker and vim.deep_equal(ctx, _last_ctx) then
      builtin.resume()
    else
      _last_picker = func
      _last_ctx = ctx
      func()
    end
  end
  return inner
end

vim.keymap.set('n', '<C-p>', builtin.find_files, opts)
vim.keymap.set('n', '<leader>p', function() builtin.find_files({ hidden = true }) end, opts) -- fzf find file
vim.keymap.set('n', '<leader>/', telescope_middleware(builtin.live_grep, function() return { cwd = vim.fn.getcwd() } end), opts) -- ripgrep find in all files
vim.keymap.set('n', '<leader>;', builtin.buffers, opts) -- list of open buffers

-- LSP Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts) -- Jump to definition (shows picker, if more than one)
vim.keymap.set('n', 'gr', builtin.lsp_references, opts) -- List of references for symbol
vim.keymap.set('n', '<leader>ee', builtin.diagnostics, opts)
vim.keymap.set('n', '<leader>e[', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<leader>e]', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'g<C-d>', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
-- vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)

vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

-- AI slop
vim.keymap.set({'n', 'v'}, '<leader>ag', ':Gen<CR>')
vim.keymap.set({'n', 'v'}, '<leader>aa', ':Gen Ask<CR>')
vim.keymap.set({'n', 'v'}, '<leader>ac', ':Gen Change_Code<CR>')

-- Clipboard
if vim.fn.has('wsl') == 1 then
    vim.g.clipboard = {
        name = "win32yank-wsl",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf"
        },
        paste = {
            ["+"] = "win32yank.exe -o --crlf",
            ["*"] = "win32yank.exe -o --crlf"
        },
        cache_enable = 0,
    }
end
