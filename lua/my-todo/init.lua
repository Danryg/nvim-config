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

local current_selection = 1
local function update_highlight()
  -- Clear existing highlights
  vim.api.nvim_buf_clear_namespace(listBuf, -1, 0, -1)
  -- Highlight current selection
  vim.api.nvim_buf_add_highlight(listBuf, -1, "IncSearch", current_selection - 1, 0, -1)
end
local function createTodoWindow(todos)
  local lines = vim.api.nvim_get_option("lines")
  local columns = vim.api.nvim_get_option("columns")

  if listBuf == nil then
    listBuf = vim.api.nvim_create_buf(false, true) -- creates a new buffer that is not listed and not loaded
    vim.api.nvim_buf_set_name(listBuf, "MyMenu")
  end

  vim.api.nvim_buf_set_option(listBuf, "modifiable", true)
  vim.api.nvim_buf_set_lines(listBuf, 0, -1, false, todos)
  vim.api.nvim_buf_set_option(listBuf, "modifiable", false)
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

  update_highlight()
  vim.api.nvim_buf_set_keymap(listBuf, "n", "j", "", {
    noremap = true,
    silent = true,
    callback = function()
      if current_selection < #todos then
        current_selection = current_selection + 1
        update_highlight()
      end
    end,
  })
  vim.api.nvim_buf_set_keymap(listBuf, "n", "k", "", {
    noremap = true,
    silent = true,
    callback = function()
      if current_selection > 1 then
        current_selection = current_selection - 1
        update_highlight()
      end
    end,
  })

  vim.api.nvim_buf_set_keymap(listBuf, "n", "1", "", {
    noremap = true,
    silent = true,
    callback = function()
      if 1 < #todos then
        current_selection =  1
        update_highlight()
      end
    end,
  })
  -- Set buffer in the new window

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
