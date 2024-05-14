return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "github/copilot.vim" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		config = function()
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")

			chat.setup({
				-- your configuration comes here
			})

			local keymap = vim.keymap

			local windowConfig = {
				layout = "float",
				title = "Copilot",
				width = 0.8,
				height = 0.8,
				relative = "editor",
			}
			-- Creates a kyemapping for quickly asking the chat for help
			keymap.set("n", "<leader>ci", function()
				-- Prompt the user for input with the message "Quick Chat: "
				local input = vim.fn.input("Quick Chat: ")
				-- If the user input is not empty
				if input ~= "" then
					-- Ask a question using the user input, with the current buffer as the context
					-- Display the chat function in a floating window titled "Copilot"
					chat.ask(input, { selection = select.buffer, window = windowConfig })
				end
				-- Provide a description for this key mapping
			end, { desc = "Ask the chat" })

			-- Set a key mapping in normal mode
			keymap.set("n", "<leader>cc", function()
				-- Toggle the chat function, with the current buffer as the context
				-- Display the chat function in a floating window titled "Copilot"
				chat.toggle({ selection = select.buffer, window = windowConfig })
				-- Provide a description for this key mapping
			end, { desc = "Toggle chat" })

			-- Set a key mapping in visual mode
			keymap.set("v", "<leader>ce", function()
				-- Ask for an explanation of how the selected code works
				chat.ask(
					"Explain how it works",
					-- Use the current visual selection as the context for the chat function
					-- Display the chat function in a floating window titled "Copilot"
					{ selection = select.visual, window = windowConfig }
				)
				-- Provide a description for this key mapping
			end, { desc = "Explain currently selected code" })

			-- Set a key mapping in visual mode
			keymap.set("v", "<leader>cd", function()
				-- Ask for documentation for the selected code
				chat.ask(
					"Please add documentation for the selected code",
					-- Use the current visual selection as the context for the chat function
					-- Display the chat function in a floating window titled "Copilot"
					{ selection = select.visual, window = windowConfig }
				)
				-- Provide a description for this key mapping
			end, { desc = "Add documentation for the selected code" })
		end,
	},
}
