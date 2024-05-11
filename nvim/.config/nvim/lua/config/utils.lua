local M = {}

function M.replace_work_in_selection()
    local curr_word = vim.fn.expand('<cword>')  -- Get the word under the cursor
    local mode = vim.fn.mode()

    if mode == 'v' or mode == "V" then
        return string.format([[:s/%s/%s/g<left><left>]], curr_word, curr_word)
    end
end

return M
