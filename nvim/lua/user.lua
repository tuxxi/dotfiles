local set = vim.opt

-- User options
set.mouse = 'a'
set.number = true

set.expandtab = true
set.autoindent = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
vim.cmd[[filetype plugin indent on]]

set.shell = "/usr/bin/fish"

-- Persistent undo
set.undodir = vim.fn.stdpath('config') .. '.undo'

-- Colors
vim.g.tokyonight_style = 'night'
vim.cmd[[colorscheme tokyonight]]

