local M = {}
local DATA = vim.fn.stdpath("data") .. "/fzf-project"

-- Return the first index with the given value (or nil if not found).
local function index_of(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end

    return nil
end

local function save_data(lines)
	local data = io.open(DATA .. '.tmp', 'w')
	for _, line in ipairs(lines) do
		data:write(table.concat({line, '\n'}))
	end
	data:close()

	-- Delete the old file
	os.remove(DATA)
	-- Rename the new file
	os.rename(DATA .. '.tmp', DATA)
end

-- see if the file exists
local function file_exists(file)
	local f = io.open(file, "rb")
	if f then f:close() end
	return f ~= nil
end

local function get_projects()
	-- Read file in VIMRUNTIME/fzf_project and each line is a project
	--- get all lines from a file, returns an empty 
	-- list/table if the file does not exist
	if not file_exists(DATA) then
		vim.cmd(string.format('call writefile([], "%s")', DATA)) -- create the data file
		return {}
	end
	local lines = {}

	for line in io.lines(DATA) do
		lines[#lines + 1] = line
	end

	return lines
end

local function add_project()
	local path = vim.fn.getcwd()
	local projects = get_projects()
	table.insert(projects, path)
	save_data(projects)
end

local function remove_project(selected)
	local projects = get_projects()

	for _, sel in pairs(selected) do
		table.remove(projects, index_of(projects, sel))
	end

	save_data(projects)
end

local function rename_project(selected)
	local projects = get_projects()
	local index = index_of(projects, selected[1])

	projects[index] = new_path
	save_data(projects)
end

function M.list()
	local fzfl = require('fzf-lua')
	local resume = fzfl.actions.resume

	fzfl.fzf_exec(get_projects(), {
		prompt = 'Projects>',
		files = {
			show_cwd_prompt = true,
			show_cwd_false = true,
		},
		actions = {
			['default'] = function(selected)
				--o.cmd = 'ls ' .. selected[1]
				--o.actions = nil
				--fzfl.files(o)
				fzfl.files({cwd = selected[1]})
			end,
			['ctrl-s'] = {add_project, resume},
			['ctrl-d'] = {remove_project, resume},
			['ctrl-g'] = {function()
				require('fzf-lua.config').__resume_data.contents = {1,2,3,4}
			end, resume}
		}
	})
end

return M
