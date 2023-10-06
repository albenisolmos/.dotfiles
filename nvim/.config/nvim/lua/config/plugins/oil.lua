return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup({
            default_file_explorer = true,
            delete_to_trash = true,
        })

        vim.keymap.set('n', '<leader>f', '<cmd>Oil<cr>')
    end
}
