vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment and decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number under cursor" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number under cursor" })

-- window managment
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- tab managment
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Disable arrow keys in normal mode
keymap.set("n", "<Down>", "", {})
keymap.set("n", "<Up>", "", {})
keymap.set("n", "<Right>", "", {})
keymap.set("n", "<Left>", "", {})

-- Disable arrow keys in visual mode
keymap.set("v", "<Down>", "", {})
keymap.set("v", "<Up>", "", {})
keymap.set("v", "<Right>", "", {})
keymap.set("v", "<Left>", "", {})

-- Disable arrow keys in insert mode
keymap.set("i", "<Down>", "", {})
keymap.set("i", "<Up>", "", {})
keymap.set("i", "<Right>", "", {})
keymap.set("i", "<Left>", "", {})

-- Terminal close
keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<leader>co", "<C-w>v <cmd>:terminal<CR> 50<C-w>|", { desc = "Open terminal" })

keymap.set("n", "<S-Tab>", "<cmd>tabn<CR>", { desc = "Next tab" })

-- Building and running
