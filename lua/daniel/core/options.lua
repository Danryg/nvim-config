
local opt = vim.opt



-- General
opt.mouse = ""

-- Tab and Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true

opt.wrap = false

-- Line numbering
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Cursor
opt.cursorline = true

-- Theme
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true




