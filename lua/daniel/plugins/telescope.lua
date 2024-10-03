return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		config = function()
			local telescope = require("telescope")

			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_to_qflist,
							["<C-x>"] = actions.send_to_qflist + actions.open_qflist,
						},
					},
				},
			})

			telescope.load_extension("fzf")
			local keymap = vim.keymap

			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local sorters = require("telescope.config").values
			-- Function to list all active LSPs and formatters in vertical splits
			local function list_all_active_lsps()
				local active_clients = vim.lsp.get_active_clients()
				if next(active_clients) == nil then
					print("No active LSPs")
					return
				end

				local lsp_names = {}

				for _, client in pairs(active_clients) do
					table.insert(lsp_names, client.name)
				end

				if next(lsp_names) == nil then
					print("No active LSPs or formatters")
					return
				end

				-- Picker for active LSPs
				pickers
					.new({}, {
						prompt_title = "Active LSPs",
						finder = finders.new_table({
							results = lsp_names,
						}),
						sorter = sorters.generic_sorter({}),
					})
					:find()
			end

			local function list_all_active_formatters()
				local active_clients = vim.lsp.get_active_clients()
				if next(active_clients) == nil then
					print("No active LSPs")
					return
				end

				local formatter_names = {}

				for _, client in pairs(active_clients) do
					if client.server_capabilities.documentFormattingProvider then
						table.insert(formatter_names, client.name)
					end
				end
				if next(formatter_names) == nil then
					print("No active LSPs or formatters")
					return
				end
				-- Picker for active formatters
				pickers
					.new({}, {
						prompt_title = "Active Formatters",
						finder = finders.new_table({
							results = formatter_names,
						}),
						sorter = sorters.generic_sorter({}),
					})
					:find()
			end

			-- Create a custom command to list all active LSPs and formatters in vertical splits
			vim.api.nvim_create_user_command("ListAllActiveLSPs", list_all_active_lsps, {})
			vim.api.nvim_create_user_command("ListAllActiveFormatters", list_all_active_formatters, {})

			keymap.set("n", "<leader>fl", "<cmd>ListAllActiveLSPs<cr>", { desc = "List all LSPs" })
			keymap.set("n", "<leader>fk", "<cmd>ListAllActiveFormatters<cr>", { desc = "List all formatters" })

			keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
			keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
			keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
			keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
			keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

			keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
		end,
	},
}
