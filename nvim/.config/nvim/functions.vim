function s:on_enter()
	if pumvisible()
		return "\<C-y>"
	elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
		return "\<CR>\<Esc>O"
	elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
		return "\<CR>\<Esc>O"
	else
		return "\<CR>"
	endif
endfun
imap <expr> <CR> <SID>on_enter()

let g:indent_guides = 0
function s:toggle_indent_guides()
	if g:indent_guides
		set listchars=tab:\ \ ,trail:·
		let g:indent_guides = 0
	else
		set listchars=tab:\│\ ,trail:·
		let g:indent_guides = 1
	endif
endfun
command ToggleIndentGuides call s:toggle_indent_guides()

function s:syn_group()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
command SyncGroup call s:syn_group()

function s:start_buffer()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Start a new buffer ...
    enew

    " ... and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber

    " Now we can just write to the buffer, whatever you want.
	call append('$', "")
    "call append('$', "   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    ")
    "call append('$', "  🭉🭁🭠🭘    🭣🭕🭌🬾   ")
    "call append('$', "  🭅█ ▁     █🭐")
    "call append('$', "  ██🬿      🭊██   ")
    "call append('$', " 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  ")
    "call append('$', " 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  ")
    "call append('$', "                 ")

    " No modifications to this buffer
    setlocal nomodifiable nomodified

    " When we go to insert mode start a new buffer, and start insert
    nnoremap <buffer><silent> e :enew<CR>
    nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
    nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
endfun

" Run after "doing all the startup stuff"
autocmd VimEnter * call s:start_buffer()
