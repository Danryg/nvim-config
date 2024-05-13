return {
	"kdheepak/lazygit.nvim",

	config = function()
		-- nvim v0.8.0
		require("lazy").setup({
			{
				"kdheepak/lazygit.nvim",
				cmd = {
					"LazyGit",
					"LazyGitConfig",
					"LazyGitCurrentFile",
					"LazyGitFilter",
					"LazyGitFilterCurrentFile",
				},
				-- optional for floating window border decoration
				dependencies = {
					"nvim-lua/plenary.nvim",
				},
			},
		})
	end,
}
