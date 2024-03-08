local M = {}

local todos = {}
function M.add()
  -- Create a new floating window for text input
  local width = 40
  local height = 2
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
    style = "minimal",
  })

  -- Set up autocommand to capture user input
  vim.api.nvim_buf_set_keymap(
    input_buf,
    "i",
    "<CR>",
    '<cmd>lua require("my-todo")._captureInput(' .. win_id .. ")<CR>",
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
  vim.cmd("autocmd! BufLeave <buffer>")
  vim.api.nvim_win_close(win_id, true)
end

function M.delete(index)
  table.remove(todos, index)
end

local function createTodoWindow(todos)
  local lines = vim.api.nvim_get_option("lines")
  local columns = vim.api.nvim_get_option("columns")

  -- Calculate todo window size
  local width = 40
  local height = #todos + 2 -- Add padding for borders

  -- Calculate todo window position
  local row = math.floor((lines - height) / 2)
  local col = math.floor((columns - width) / 2)

  -- Create a new split window
  local win_id = vim.api.nvim_open_win(0, true, {
    relative = "win",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
  })

  -- Set buffer in the new window
  vim.api.nvim_win_set_buf(win_id, vim.api.nvim_create_buf(false, true))

  -- Populate buffer with todos
  vim.api.nvim_buf_set_lines(vim.api.nvim_win_get_buf(win_id), 0, -1, true, todos)
end

function M.list()
  local tempTodo = ""
  for i, todo in ipairs(todos) do
   tempTodo = tempTodo ..  todo .. ","
  end
  createTodoWindow(tempTodo)
end

return M
