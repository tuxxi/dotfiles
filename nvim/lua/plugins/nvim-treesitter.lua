-- TreeSitter languages setup
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
      "c",
      "cpp",
      "cmake",
      "dockerfile",
      "fish",
      "go",
      "gomod",
      "gosum",
      "gowork",
      "html",
      "ini",
      "lua",
      "make",
      "markdown",
      "python",
      "rust",
      "starlark",
      "vim",
      "yaml",
      "zig",
  },
  highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
  },
}
