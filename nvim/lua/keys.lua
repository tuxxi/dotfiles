vim.g.mapleader = ' '
vim.g.localleader = ' '

local opts = { noremap = true, silent = true }

-- key mappings
vim.keymap.set('n', '<Esc><Esc>', '<cmd>noh<cr>', opts) -- remove search highlight
vim.keymap.set('n', '<leader>d', '<cmd>bd!<cr>', opts) -- close current buffer

-- Telescope
vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<cr>', opts) -- ripgrep find in all files
vim.keymap.set('n', '<leader>p', '<cmd>Telescope find_files<cr>', opts) -- fzf find file
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>', opts)
vim.keymap.set('n', '<leader>;', '<cmd>Telescope buffers<cr>', opts) -- list of open buffers

-- LSP Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts) -- Jump to definition (shows picker, if more than one)
vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts) -- List of references for symbol
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
vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)

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
