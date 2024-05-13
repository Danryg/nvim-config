return {
	"goolord/alpha-nvim",
	dependancies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		-- local alpha = require("alpha")
		-- local dashboard = require("alpha.themes.startify")

		require("alpha").setup(require("alpha.themes.startify").config)
    --require'alpha'.setup(require'alpha.themes.dashboard'.config)
	end,
}
