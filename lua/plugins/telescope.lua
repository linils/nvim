return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ef", builtin.find_files)
			vim.keymap.set("n", "<leader>eg", builtin.live_grep)
			vim.keymap.set("n", "<leader>eb", builtin.buffers)
		end,
	},
}
