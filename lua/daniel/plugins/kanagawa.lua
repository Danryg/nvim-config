return {
	"dasupradyumna/midnight.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		vim.cmd("colorscheme midnight")

		require("midnight").setup({
			styles = {
				comments = "italic",
				functions = "italic",
				keywords = "italic",
				strings = "italic",
				variables = "italic",
			},
			dark_float = true,
			dark_sidebar = true,
			transparent = false,
			transparent_sidebar = false,
			transparent_float = false,
			HighlightGroup = {
				Normal = { fg = "#ffffff", bg = "#000000" },
				NormalNC = { fg = "#ffffff", bg = "#000000" },
				NormalFloat = { fg = "#ffffff", bg = "#000000" },
				NormalNCFloat = { fg = "#ffffff", bg = "#000000" },
				CursorLine = { fg = "#ffffff", bg = "#000000" },
				CursorColumn = { fg = "#ffffff", bg = "#000000" },
				CursorColumnNC = { fg = "#ffffff", bg = "#000000" },
				CursorColumnNr = { fg = "#ffffff", bg = "#000000" },
				CursorColumnNrNC = { fg = "#ffffff", bg = "#000000" },
				CursorLineNr = { fg = "#ffffff", bg = "#000000" },
				CursorLineNrNC = { fg = "#ffffff", bg = "#000000" },
				CursorLineNC = { fg = "#ffffff", bg = "#000000" },
			},
		})
	end,
}

--return {
--	"rebelot/kanagawa.nvim",
--  priority = 1000,
--	config = function()
--		vim.cmd("colorscheme kanagawa-wave")
--	end,
--}

--return {
--
-- "catppuccin/nvim",
--  name = "catppuccin",
--  priority = 1000,
--  config = function()
--    vim.cmd.colorscheme "catppuccin"
--   end
--}
