-- TreeSitter languages setup
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "cmake", "dockerfile", "fish", "go", "html", "lua", "make", "python", "rust", "yaml" },
  highlight = {
      enable = true, 
      additional_vim_regex_highlighting = false,
  },
}
