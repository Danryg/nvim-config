return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_save_enabled = true,
      auto_sessions_supress_dirs = {"~/", "~/Dev/", "~/Desktop/", "~/Documents/", "~/Downloads/", "~/Pictures/", "~/Videos/"},
		})

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc="Restore session for cwd" })
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc="Save session for cwd" })
	end,
}
