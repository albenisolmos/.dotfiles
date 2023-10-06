local o = vim.opt
local g = vim.g

o.compatible = false
o.termguicolors = true
o.bg = 'dark'
vim.cmd('colorscheme sol')
vim.cmd('syntax on')
o.lazyredraw = true
o.title = true
o.titlestring = '%t - Vim'
o.number = true
o.relativenumber = true
o.cursorline = true
o.guicursor='a:block,r-sm:hor100,i:block-iCursor,v:block-vCursor'
o.showtabline= 1
o.winwidth = 10
o.hidden = true

-- Tabs & Spaces
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true

-- Text
o.autoindent = true
o.wrap = true
o.linebreak = true
o.breakindent = true
o.list = true
o.fillchars.vert = 'vert:│ '
o.listchars.tab = ' '
o.listchars.trail = '• '

-- Fold
o.foldmethod = 'expr'
o.foldenable = false
o.foldlevel = 1
o.fillchars.fold = 'fold: '
o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Seaching
o.incsearch = true
o.hlsearch = true

-- Backup & Undo
o.swapfile = true
o.writebackup = true
o.backupdir:append(os.getenv('HOME') .. '/.local/share/nvim/backup')
o.backupdir:append('.')

-- Splitting
o.splitkeep = 'cursor'
o.splitright = true
o.splitbelow = true

-- Auto-completion
o.completeopt = 'menuone,noinsert,preview'

-- Status
o.showmode = false
o.showcmdloc = 'statusline'
o.ruler = true
o.rulerformat="%50(%=%=%f\z
    %( %M %)%( %R %)%( %H %)\z
     %{fnamemodify(getcwd(),':t')}%)"

-- nose
o.scrolloff= 5
o.mouse = 'a'
o.shortmess:append('c')
o.ttyfast = true
o.clipboard = 'unnamedplus'
o.formatoptions:append('t')
o.jumpoptions:append('view')

-- Ignore files
o.wildignore = {
    '*.pyc,*.o',
    'build/*',
    '**/node_modules/*',
    '**/.git/*'
}

vim.diagnostic.config {
    virtual_text = false
}

-- Lets
g.venter_disable_vertsplit = true
g.user_emmet_leader_key = '<C-a>'
g.gitgutter_sign_priority = 10
g.gitgutter_map_keys = 0
g.gitgutter_sign_added = '│'
g.gitgutter_sign_removed  = '│'
g.gitgutter_sign_modified  = '│'
g.gitgutter_sign_removed_first_line = '‾'
g.gitgutter_sign_removed_above_and_below = '_¯'
g.gitgutter_sign_modified_removed   = '│_'
g.lf_replace_netrw = true
g.venter_width = 20

-- Disable built-in plugins
g.loaded_gzip = true
g.loaded_tar = true
g.loaded_tarPlugin = true
g.loaded_zip = true
g.loaded_zipPlugin = true
g.loaded_getscript = true
g.loaded_getscriptPlugin = true
g.loaded_vimball = true
g.loaded_vimballPlugin = true
g.loaded_matchit = true
--g.loaded_matchparen = true
g.loaded_2html_plugin = true
g.loaded_logiPat = true
g.loaded_rrhelper = true
g.loaded_netrw = true
g.loaded_netrwPlugin = true
g.loaded_netrwSettings = true
g.loaded_netrwFileHandlers = true
