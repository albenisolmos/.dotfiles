local map = vim.keymap.set
vim.g.mapleader = " "

local function check_keyboard()
	if vim.g.keyboard == "colemak" or os.getenv("KEYBOARD_LAYOUT") == "colemak" then
		vim.opt.langmap = "nh,hn,ej,je,ik,ki,ol,lo,NH,HN,EJ,JE,IK,KI,OL,LO"
	else
		vim.opt.langmap = ""
	end
end

-- Save / Exit
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>c", "<cmd>bd<cr>")
map("n", "<leader>Q", "<cmd>q!<cr>")

-- Resize buffer
map("n", "<C-Left>", "<c-w><", { noremap = true })
map("n", "<C-Right>", "<c-w>>", { noremap = true })
map("n", "<C-Up>", "<c-w>+", { noremap = true })
map("n", "<C-Down>", "<c-w>-", { noremap = true })

-- Terminal Mode
map("t", "<C-6>", "<C-w>N<C-6>")
map("t", "<Esc>", "<C-w>N")

-- Replacement
map("v", "<leader>rr", ":s///g<left><left><left>")
map("n", "<leader>rr", ":%s///g<left><left><left>")
map("n", "<leader>rl", ":.s///g<left><left><left>")
map("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<left><left>")
map("v", "<leader>rw", require("config.utils").replace_work_in_selection, { expr = true })

-- Move lines
map("n", "<c-j>", ":m .+1<CR>==")
map("n", "<c-k>", ":m .-2<CR>==")
map("v", "<c-j>", ":m '>+1<CR>gv=gv")
map("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- Others
map({ "n", "x" }, "<leader>p", [["0p]])
map("n", "<C-d>", "<C-d>zz", { noremap = true })
map("n", "<C-u>", "<C-u>zz", { noremap = true })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<leader>d", '<cmd>cd %:p:h | echo "cd " . expand("%:p:h")<cr>')
map("n", "<leader>hl", "<cmd>nohlsearch<cr>")
map("n", "<leader>=", "gg=G''")
map("n", "<leader>C", function()
	vim.g.keyboard = vim.g.keyboard == "colemak" and "qwerty" or "colemak"
	check_keyboard()
end, { noremap = true })

-- Text-objects
map("o", "il", ":<c-u>normal! $v^<cr>", { noremap = true, silent = true })
map("x", "il", ":<c-u>normal! $v^<cr>", { noremap = true, silent = true })
map("o", "al", ":<c-u>normal! $v0<cr>", { noremap = true, silent = true })
map("x", "al", ":<c-u>normal! $v0<cr>", { noremap = true, silent = true })

check_keyboard()
