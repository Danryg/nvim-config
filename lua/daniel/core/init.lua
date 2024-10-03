require("daniel.core.options")
require("daniel.core.keymaps")

function ListActiveLSPs()
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		print("No active LSPs")
		return
	end

	print("Active LSPs:")
	for _, client in pairs(clients) do
		print(client.name)
	end
end
vim.api.nvim_create_user_command("ListActiveLSPs", ListActiveLSPs, {})
