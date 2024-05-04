return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		ensure_installed = { "lua_ls", "tsserver", "html", "clangd", "pyright", "black", "tailwindcss" },
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
      -- Lua language server
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

      -- Typescript language server
			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

      -- HTML language server
			lspconfig.html.setup({
				capabilities = capabilities,
			})

      -- C/C++ language server
			lspconfig.clangd.setup({
				filetypes = { "c", "cpp" },

				cmd = {
					"clangd",
					"--header-insertion=never",
					"--suggest-missing-includes",
          "D:/avrgcc/avr-gcc-13.2.0-x64-windows/include",
				},
				capabilities = capabilities,
			})

      -- Python language server
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

      -- TailwindCSS language server
      lspconfig.tailwindcss.setup({
        cmd = { "tailwindcss-language-server", "--stdio" },
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue" },
        capabilities = capabilities,
      })
      
      -- Eslint language server
      lspconfig.eslint.setup({
        capabilities = capabilities,
      })

      -- Keymaps
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
		end,
	},
	{
		"williamboman/nvim-lsp-installer",
		config = function()
			require("nvim-lsp-installer").setup({})
		end,
	},
}
