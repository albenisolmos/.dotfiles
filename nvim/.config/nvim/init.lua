local me = require('me')

me.setup {
    status = 'medium',
    border = 'rounded',
    float = {
        border = 'rounded',
    },
    lsp_clients = {
        'svelte', 'cssls',
        'rust_analyzer','clangd',
        'pyright', 'tsserver',
        'tailwindcss',
        lua_ls = { settings = { Lua = {
            completion = {
                enable = true,
                callSnippet = 'Both'
            }
        }}}
    }
}

require('me.keymaps')
require('me.plugins')
require('me.settings')
require('me.commands')
require('me.statusline').init()

vim.cmd('source ~/.config/nvim/functions.vim')
me.end_setup()
