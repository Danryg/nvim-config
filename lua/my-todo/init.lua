local M = {}

local todos = {}
function M.add()
	-- Create a new floating window for text input
	local width = 40
	local height = 1
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local input_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_option(input_buf, "bufhidden", "wipe")

	local win_id = vim.api.nvim_open_win(input_buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "single",
		title = "Add TODO",
		style = "minimal",
	})

	vim.cmd("startinsert")
	-- Set up autocommand to capture user input
	vim.api.nvim_buf_set_keymap(
		input_buf,
		"i",
		"<CR>",
		'<cmd>lua require("my-todo")._captureInput(' .. win_id .. ")<CR>",
		{ noremap = true, silent = true }
	)

	vim.api.nvim_buf_set_keymap(
		input_buf,
		"i",
		"<Esc>",
		'<cmd>lua require("my-todo")._closeInput(' .. win_id .. ")<CR>",
		{ noremap = true, silent = true }
	)
end

-- Function to capture user input and add todo
function M._captureInput(win_id)
	local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
	local todo = string.sub(line, 1) -- Remove any trailing newline
	table.insert(todos, todo)
	print("Added todo: " .. todo)

	-- Clean up autocommand and close window
	vim.cmd("stopinsert")
	vim.cmd("autocmd! BufLeave <buffer>")
	vim.api.nvim_win_close(win_id, true)
end

function M._closeInput(win_id)
	vim.cmd("stopinsert")
	vim.cmd("autocmd! BufLeave <buffer>")
	vim.api.nvim_win_close(win_id, true)
end

function M.delete(index)
	table.remove(todos, index)
end

local listBuf = nil

local function createTodoWindow(todos)
	local lines = vim.api.nvim_get_option("lines")
	local columns = vim.api.nvim_get_option("columns")

	if listBuf == nil then
		listBuf = vim.api.nvim_create_buf(false, true) -- creates a new buffer that is not listed and not loaded
		vim.api.nvim_buf_set_name(listBuf, "MyMenu")
	end
	vim.api.nvim_buf_set_lines(listBuf, 0, -1, false, todos)

	-- Calculate todo window size
	local width = 40
	local height = #todos + 2 -- Add padding for borders

	-- Calculate todo window position
	local row = math.floor((lines - height) / 2)
	local col = math.floor((columns - width) / 2)

	-- Create a new split window
	local win_id = vim.api.nvim_open_win(listBuf, true, {
		relative = "editor",
		width = width,
		height = #todos,
		row = row,
		col = col,
		border = "rounded",
		style = "minimal",
	})

	-- Set buffer in the new window

	for i, option in ipairs(todos) do
		vim.api.nvim_buf_set_keymap(listBuf, "n", tostring(i), "", {
			noremap = true,
			silent = true,
			callback = function()
				print("Selected: " .. option)
				vim.api.nvim_win_close(win, false)
			end,
		})
	end
	-- Populate buffer with todos
end

function M.list()
	local tempTodo = {}
	for i, todo in ipairs(todos) do
		tempTodo[i] = "(" .. i .. ") " .. todo
	end
	print(tempTodo)
	createTodoWindow(tempTodo)
end

return M
