local current_mode = ''
local statusline_bg

local colors = {
	normal = '#626262',
	insert = '#FFAD57',
	visual = '#B16286',
	cmd = '#B16286'
}

local color_for_modes = {
    i = colors.insert,
    v = colors.visual,
    c = colors.cmd
}

local mode_map = {
	['n'] = 'N',
	['no'] = 'n·operator pending',
	['v'] = 'V',
	['V'] = 'V·Line',
	[''] = 'V·Block',
	['s'] = 'Select',
	['S'] = 'S·Line',
	[''] = 'S·Block',
	['i'] = 'I',
	['R'] = 'R',
	['Rv'] = 'V·Replace',
	['c'] = 'CMD',
	['cv'] = 'Vim Ex',
	['ce'] = 'EX',
	['r'] = 'Prompt',
	['rm'] = 'More',
	['r?'] = 'Confirm',
	['!'] = 'SH',
	['t'] = 'Term'
}

function get_git_branch_system()
    -- Run git command to get branch name
    local result = vim.system({'git', 'branch', '--show-current'}, {
        cwd = vim.fn.getcwd(),
        text = true,
    }):wait()
    
    if result.code == 0 and result.stdout and result.stdout ~= '' then
        -- Trim whitespace and return
        return vim.trim(result.stdout)
    end
    
    return nil
end

local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation# " .. count["info"]
	end

	return table.concat({errors, warnings, hints, info})
end

local function set_hi_color(color)
	vim.api.nvim_set_hl(0, 'User1', {bg = color})
	vim.api.nvim_set_hl(0, 'User2', {fg = color, bg = statusline_bg})
end

local function statusline()
	local new_mode = vim.api.nvim_get_mode().mode

	if current_mode == new_mode then
		goto _end
    elseif color_for_modes[new_mode] then
		set_hi_color(color_for_modes[new_mode])
	else
		set_hi_color(colors.normal)
	end

	current_mode = new_mode

	::_end::
	--[[return table.concat({
		"%#Statusline# ",
		mode_map[new_mode] or new_mode,
		"%=\z
	    %#User2#%f%*\z
		%( %R%)%( %H%)%( %M%)\z
		%=",
		lsp(),
		"  %{fnamemodify(getcwd(),':t')} "
	})]]
	return table.concat({
        ' ',
		mode_map[new_mode] or new_mode,
		"%=\z
	    %f\z
		%( %R%)%( %H%)%( %M%)\z
		%=",
		lsp(),
		"⇅ ", get_git_branch_system(),
		"   %{fnamemodify(getcwd(),':t')} "
	})
end

statusline_bg = vim.api.nvim_get_hl_by_name('StatusLine', {}).background

local augroup = vim.api.nvim_create_augroup('Statusline', {clear = true})
vim.api.nvim_create_autocmd('ModeChanged', {
    group = augroup,
    callback = function()
        vim.opt.statusline = statusline()
    end
})

vim.opt.statusline = statusline()
