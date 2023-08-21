return {'alexghergh/nvim-tmux-navigation',
    config = function()
        require('nvim-tmux-navigation').setup {
            disable_when_zoomed = true, -- defaults to false
            keybindings = {
                left = "<C-n>",
                down = "<C-e>",
                up = "<C-i>",
                right = "<C-o>",
                --last_active = "<C-a>",
                --next = "<C-Space>",
            }
        }
    end
}
