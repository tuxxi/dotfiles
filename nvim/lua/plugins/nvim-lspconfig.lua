local servers = {
  {
    name = 'pyright'
  },
  {
    name = 'clangd',
    cmd = {
      "clangd",
      "--background-index",
      -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
      -- to add more checks, create .clang-tidy file in the root directory
      -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
      "--clang-tidy",
      "--completion-style=bundled",
      "--cross-file-rename",
      "--header-insertion=iwyu",
    }
  },
  {
    name = 'gopls'
  },
}

-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
})

local on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp.name].setup {
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    cmd = lsp.cmd,
    on_attach = on_attach,
  }
end
