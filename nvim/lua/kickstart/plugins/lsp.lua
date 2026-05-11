return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      local util = require 'lspconfig.util'

      lspconfig.dartls.setup {
        cmd = { 'dart', 'language-server', '--protocol=lsp' },
        filetypes = { 'dart' },

        root_dir = util.root_pattern('pubspec.yaml', '.git'),

        init_options = {
          closingLabels = true,
          flutterOutline = true,
          onlyAnalyzeProjectsWithOpenFiles = true,
          outline = true,
          suggestFromUnimportedLibraries = true,
        },
      }
    end,
  },
}
