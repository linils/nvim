return {
	"WTFox/jellybeans.nvim",
	config = function()
		vim.opt.background = "dark"
		require("jellybeans").setup({
			flat_ui = false,
			italics = false,
		})
		vim.cmd.colorscheme("jellybeans")
	end,
}
