local M = {telescope = {}}

function M.fzf_project()
	require('fzf-lua').fzf_exec("rg --files", {
		actions = {
			-- Use fzf-lua builtin actions or your own handler
			['default'] = require'fzf-lua'.actions.file_edit,
			['ctrl-y'] = util.add_project
		}
	})
end

return M
