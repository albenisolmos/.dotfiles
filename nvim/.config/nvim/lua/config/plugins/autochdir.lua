if false then
    return {}
else
    return {dir = '~/Dev/vim-plugins/autochdir.nvim', config = function()
        require('autochdir').setup {
            flags = {
                ['rs'] = {'Cargo.toml'}
            },
            keep_dir = true
        }
    end}
end
