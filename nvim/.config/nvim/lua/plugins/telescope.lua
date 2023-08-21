local builtin = {}
local find_by_git = true

local function toggle_find_method()
	find_by_git = not find_by_git
	print('Find method:', find_by_git and 'Git' or 'Files')
end

local function find_files()
	local results = require('telescope.utils').get_os_command_output({'git', 'rev-parse', '--git-dir'})

	if results[1] and find_by_git then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.1',
		dependencies = {'nvim-lua/plenary.nvim'},
		keys = {
			{'tg', toggle_find_method},
			{'tp', function()
				require('telescope').extensions.project.project()
			end},
			{'tt', find_files},
			{'to', function() builtin.oldfiles() end},
			{'tT', function() builtin.find_files() end},
			{'tb', function() builtin.buffers() end},
			{'tl', function() builtin.live_grep() end},
			{'ti', function() builtin.lsp_document_symbols() end},
		},
		config = function()
			builtin = require('telescope.builtin')
			require('telescope').setup {
				defaults = {
					preview = false,
				},
				pickers = {
					git_files = {theme = 'dropdown', hidden = true},
					oldfiles = {theme = 'dropdown'},
					find_files = {theme = 'dropdown', hidden = true},
					buffers = {theme = 'dropdown'},
					live_grep = {theme = 'dropdown'},
					lsp_document_symbols = {theme = 'dropdown'}
				},
				extensions = {
					project = {theme = 'dropdown'},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					}
				}
			}
		end
	},
	{'nvim-telescope/telescope-project.nvim', config = function()
		require('telescope').load_extension('project')
	end},
	{'nvim-telescope/telescope-fzf-native.nvim', build = 'make', config = function()
		require('telescope').load_extension('fzf')
	end}
}
