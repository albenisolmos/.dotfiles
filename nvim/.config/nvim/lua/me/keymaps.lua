local map = vim.keymap.set
vim.g.mapleader = ' '

local function check_keyboard()
	if vim.g.keyboard == 'colemak' or
		os.getenv('KEYBOARD_LAYOUT') == 'colemak' then
		vim.opt.langmap = 'nh,hn,ej,je,ik,ki,ol,lo,NH,HN,EJ,JE,IK,KI,OL,LO'
	else
		vim.opt.langmap = ''
	end
end

-- Save / Exit
map('n', '<leader>w', '<cmd>w<cr>')
map('n', '<leader>q', '<cmd>q<cr>')
map('n', '<leader>Q', '<cmd>q!<cr>')
map('n', '<leader>x', '<cmd>x<cr>')

-- Resize buffer
map('n', '<C-Left>', '<c-w><', {noremap = true})
map('n', '<C-Right>', '<c-w>>', {noremap = true})
map('n', '<C-Up>', '<c-w>+', {noremap = true})
map('n', '<C-Down>', '<c-w>-', {noremap = true})

-- Terminal Mode
map('t', '<C-6>', '<C-w>N<C-6>')
map('t', '<Esc>', '<C-w>N')

-- Replacement
map('v', '<leader>r', ':s///g<left><left><left>')
map('n', '<leader>r', ':%s///g<left><left><left>')
map('n', '<leader>R', ':s///g<left><left><left>')
map('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<left><left><left>')

-- Others
map('n', '<C-d>', '<C-d>zz', {noremap = true})
map('n', '<C-u>', '<C-u>zz', {noremap = true})
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<leader>p', '`[v`]')
map('n', '<leader>d', '<cmd>cd %:p:h | echo "cd " . expand("%:p:h")<cr>')
map('n', 'tf', '<cmd>Lf<cr>')
map('n', '<leader>h', '<cmd>nohlsearch<cr>')
map('n', '<leader>g', "gg=G''")
map('i', '<c-d>', '<Esc>diwi')
map('n', '<leader>i', '<cmd>TSHighlightCapturesUnderCursor<cr>')
map('n', '<leader>C', function()
	vim.g.keyboard = vim.g.keyboard == 'colemak' and 'qwerty' or 'colemak'
	check_keyboard()
end, {noremap = true})

-- Text-objects
map('o', 'il', ':<c-u>normal! $v^<cr>', {noremap = true, silent = true})
map('x', 'il', ':<c-u>normal! $v^<cr>', {noremap = true, silent = true})
map('o', 'al', ':<c-u>normal! $v0<cr>', {noremap = true, silent = true})
map('x', 'al', ':<c-u>normal! $v0<cr>', {noremap = true, silent = true})

check_keyboard()
