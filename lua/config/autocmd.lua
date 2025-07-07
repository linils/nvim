vim.api.nvim_create_autocmd({ "VimLeave" }, {
	group = restore_cursor_augroup,
	desc = "restore the cursor shape on exit of neovim",
	command = "set guicursor=a:ver20",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = arg.buf })
	end,
})
