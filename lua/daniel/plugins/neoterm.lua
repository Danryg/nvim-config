return {
	"kassio/neoterm",
	config = function()
		local neoterm_bufnr = nil
		-- function to open a terminal in a new split
		function _G.open_terminal()
			vim.cmd("vsplit")
			vim.cmd("vertical resize 50")
			vim.cmd(":Topen")
			neoterm_bufnr = vim.fn.bufnr("%")
		end

		-- closes the lates terminal
		function _G.close_terminal()
			vim.cmd("Tclose")
		end

		-- toggle terminal

		-- Function to toggle the Neoterm terminal
		function ToggleNeoterm()
			if neoterm_bufnr and vim.fn.bufexists(neoterm_bufnr) == 1 then
				for _, tabnr in ipairs(vim.api.nvim_list_tabpages()) do
					-- Iterate over all windows in the current tab
					for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(tabnr)) do
						-- Check if the current window contains the target buffer
						if vim.api.nvim_win_get_buf(winid) == neoterm_bufnr then
							-- Switch to the tab containing the target buffer
							vim.api.nvim_set_current_tabpage(tabnr)
							-- Focus on the window containing the target buffer
							vim.api.nvim_set_current_win(winid)
							print(
								"Focused on tab " .. vim.api.nvim_tabpage_get_number(tabnr) .. " and window " .. winid
							)
							return
						end
					end
				end

				vim.cmd("vsplit")
				vim.cmd("vertical resize 50")
				vim.api.nvim_set_current_buf(neoterm_bufnr)
			end
			vim.cmd("vsplit")
			vim.cmd("vertical resize 50")
			vim.cmd(":Topen")
			neoterm_bufnr = vim.fn.bufnr("%")
		end

		function _G.build()
			ToggleNeoterm()
			vim.cmd("$")
			vim.cmd("Tkill")
			vim.cmd("Texec build.bat")
			vim.cmd("Texec .\\build\\main.exe")
			neoterm_bufnr = vim.fn.bufnr("%")
		end
		function _G.test1() end
		function _G.test2()
			if neoterm_bufnr and vim.fn.buflisted(neoterm_bufnr) == 1 then
				print("Buffer is listed")
			else
				print("Buffer is not listed")
			end
		end
		function _G.test3()
			if neoterm_bufnr and vim.fn.bufloaded(neoterm_bufnr) == 1 then
				print("Buffer is loaded")
			else
				print("Buffer is not loaded")
			end
		end
		function _G.test4()
			local windows = vim.fn.win_findbuf(neoterm_bufnr)
			if neoterm_bufnr and #windows > 0 then
				print("Buffer is showing")
			else
				print("Buffer is not showing")
			end
		end
		local keymap = vim.keymap
		keymap.set("n", "<leader>tt", ToggleNeoterm, { noremap = true, silent = true, desc = "Toggle terminal" })
		keymap.set(
			"n",
			"<leader>tv",
			"<cmd>Tvertical<cr>",
			{ noremap = true, silent = true, desc = "Vertical terminal" }
		)
		keymap.set("n", "<leader><F5>", build, { desc = "Build" })
		keymap.set("n", "<leader><F1>", test1, { desc = "focus" })
		keymap.set("n", "<leader><F2>", test2, { desc = "islisted" })
		keymap.set("n", "<leader><F3>", test3, { desc = "isloaded" })
		keymap.set("n", "<leader><F4>", test4, { desc = "isshowing" })
	end,
}
