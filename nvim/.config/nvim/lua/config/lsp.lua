-- LSP configuration

local lspconfig = require('lspconfig')
-- Set up completion.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Python language server
lspconfig.pyright.setup {
  capabilities = capabilities
}
-- Typescript language server
lspconfig.tsserver.setup {
  capabilities = capabilities
}
-- PHP language server
lspconfig.phpactor.setup {
  capabilities = capabilities
}
-- Svelte language server
lspconfig.svelte.setup {
  capabilities = capabilities
}
-- rust-analyzer language server
lspconfig.rust_analyzer.setup {
  capabilities = capabilities
}

-- ccls language server
lspconfig.ccls.setup {
  capabilities = capabilities
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


-- Diagnostic sign icons and colors
vim.fn.sign_define('DiagnosticSignError', { text='󰅜 ', texthl='DiagnosticSignError'   })
vim.fn.sign_define('DiagnosticSignHint',  { text='󰋼 ', texthl='DiagnosticSignDefault' })
vim.fn.sign_define('DiagnosticSignInfo',  { text='󰋼 ', texthl='DiagnosticSignDefault' })
vim.fn.sign_define('DiagnosticSignWarn',  { text='󰀩 ', texthl='DiagnosticSignWarn'    })

