return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {},
	config = function()
		local chat = require("CopilotChat")
		local select = require("CopilotChat.select")

		local windowConfig = {
			layout = "vertical",
			width = 0.5, -- 50% of the editor width
			-- layout = "float",
			-- width = 80, -- Fixed width in columns
			-- height = 20, -- Fixed height in rows
			-- border = "rounded", -- 'single', 'double', 'rounded', 'solid'
			-- title = "🤖 AI Assistant",
			-- zindex = 100, -- Ensure window stays on top
		}

		local headersConfig = {
			user = "👤 You",
			assistant = "🤖 Copilot",
			tool = "🔧 Tool",
		}

		chat.setup({
			window = windowConfig,
			headers = headersConfig,
			separator = "━━",
			auto_fold = true, -- Automatically folds non-assistant messages
		})

		local keymap = vim.keymap

		-- Creates a kyemapping for quickly asking the chat for help
		keymap.set("n", "<leader>ci", function()
			-- Prompt the user for input with the message "Quick Chat: "
			local input = vim.fn.input("Quick Chat: ")
			-- If the user input is not empty
			if input ~= "" then
				-- Ask a question using the user input, with the current buffer as the context
				-- Display the chat function in a floating window titled "Copilot"
				chat.ask(input, { selection = select.buffer, window = windowConfig, headers = headersConfig })
			end
			-- Provide a description for this key mapping
		end, { desc = "Ask the chat" })

		-- Set a key mapping in normal mode
		keymap.set("n", "<leader>cc", function()
			-- Toggle the chat function, with the current buffer as the context
			-- Display the chat function in a floating window titled "Copilot"
			chat.toggle({ selection = select.buffer, window = windowConfig, headers = headersConfig })
			-- Provide a description for this key mapping
		end, { desc = "Toggle chat" })

		-- Set a key mapping in visual mode
		keymap.set("v", "<leader>ce", function()
			-- Ask for an explanation of how the selected code works
			chat.ask(
				"Explain how it works",
				-- Use the current visual selection as the context for the chat function
				-- Display the chat function in a floating window titled "Copilot"
				{ selection = select.visual, window = windowConfig, headers = headersConfig }
			)
			-- Provide a description for this key mapping
		end, { desc = "Explain currently selected code" })

		keymap.set("v", "<leader>cc", function()
			-- Ask for an explanation of how the selected code works
			chat.open({ selection = select.visual, window = windowConfig, headers = headersConfig })
			-- Provide a description for this key mapping
		end, { desc = "Explain currently selected code" })

		keymap.set("v", "<leader>cd", function()
			chat.ask(
				"Please add documentation for the selected code",
				{ selection = select.visual, window = windowConfig, headers = headersConfig }
			)
		end, { desc = "Add documentation for the selected code" })
	end,
}
