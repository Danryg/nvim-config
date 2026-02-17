return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		dap.adapters.coreclr = {
			type = "executable",
			command = "/home/danryg/libs/netcoredbg/netcoredbg/netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/API/bin/Debug/net10.0/API.dll", "file")
				end,
				env = {
					ASPNETCORE_ENVIRONMENT = "Development",
					DOTNET_ENVIRONMENT = "Development",
				},
			},
		}

		local keymap = vim.keymap

		keymap.set("n", "<leader>ib", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		keymap.set("n", "<leader>ic", dap.continue, { desc = "Continue Execution" })
		keymap.set("n", "<leader>is", dap.step_over, { desc = "Step Over" })
		keymap.set("n", "<leader>ii", dap.step_into, { desc = "Step Into" })
		keymap.set("n", "<leader>io", dap.step_out, { desc = "Step Out" })
		keymap.set("n", "<leader>ir", dap.repl.open, { desc = "Open REPL" })
	end,
}
