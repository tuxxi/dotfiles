local lspconfig = require 'lspconfig'

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
    },
  },
  {
    name = 'gopls',
    cmd_env = { GOFLAGS="-tags=windows,linux"},
  },
  {
    name = 'golangci_lint_ls',
  },
  {
    name = 'rust_analyzer',
    cmd = {
      "rustup", "run", "stable", "rust-analyzer",
    },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          enable = true,
          command = {
            'cargo', 'clippy', '--workspace', '--message-format=json', '--all-targets', '--all-features'
          },
        },
      },
    },
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
  lspconfig[lsp.name].setup {
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
    cmd = lsp.cmd,
    cmd_env = lsp.cmd_env,
    settings = lsp.settings,
    init_options = lsp.init_options,
    root_dir = lsp.root_dir,
    on_attach = on_attach,
  }
end
