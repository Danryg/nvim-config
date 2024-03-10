vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set clipboard^=unnamed,unnamedplus")
vim.cmd("set conceallevel=1")
vim.cmd("set cursorline")
vim.cmd("set mouse=")

vim.keymap.set("n", "<Down>"," :echoe 'use j'<CR>", {})
vim.keymap.set("n", "<Up>"," :echoe 'use k'<CR>", {})
vim.keymap.set("n", "<Right>"," :echoe 'use l'<CR>", {})
vim.keymap.set("n", "<Left>"," :echoe 'use h'<CR>", {})
-- Test he jag heter Daniel
vim.keymap.set("v", "<Down>"," :echoe 'use j'<CR>", {})
vim.keymap.set("v", "<Up>"," :echoe 'use k'<CR>", {})
vim.keymap.set("v", "<Right>"," :echoe 'use l'<CR>", {})
vim.keymap.set("v", "<Left>"," :echoe 'use h'<CR>", {})

local todo = require('my-todo');

vim.keymap.set("n", "<space>tl",todo.list, {})
vim.keymap.set("n", "<space>ta",todo.add, {})

