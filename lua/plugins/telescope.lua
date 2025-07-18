return {
        {
                "nvim-telescope/telescope.nvim",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "nvim-telescope/telescope-ui-select.nvim",
                },
                config = function()
                        local telescope = require("telescope");
                        telescope.setup({
                                defaults = {
                                        layout_strategy = "horizontal",
                                        sorting_strategy = "ascending",
                                        layout_config = {
                                                width = 0.9,
                                                height = 0.9,
                                                prompt_position = "top",
                                        },
                                        results_title = false,
                                        prompt_title = false,
                                        prompt_prefix = " ",
                                }
                        })
                        local builtin = require("telescope.builtin")
                        vim.keymap.set("n", "<leader>f", builtin.find_files)
                        vim.keymap.set("n", "<leader>g", builtin.live_grep)
                        vim.keymap.set("n", "<leader>b", builtin.buffers)
                        vim.keymap.set('n', "<leader>s", builtin.lsp_document_symbols)
                        vim.keymap.set('n', "<leader>S", builtin.lsp_workspace_symbols)
                end,
        },
}
