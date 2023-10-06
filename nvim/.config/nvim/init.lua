local config = require('config.setup')

config.init {
    status = 'medium',
    border = 'rounded',
    float = {
        border = 'rounded',
    },
    lsp_clients = {
        'svelte', 'cssls',
        'rust_analyzer','clangd',
        'pyright', 'tsserver',
        'tailwindcss', 'astro',
        lua_ls = { settings = { Lua = {
            completion = {
                enable = true,
                callSnippet = 'Both'
            }
        }}}
    }
}

require('config.keymaps')
require('config.lazy')
require('config.settings')
require('config.commands')

config.end_init()
