vim.keymap.set("n", "<Leader>qq", ":qa!<CR>")
vim.keymap.set("n", "<Leader>nh", ":nohl<CR>")

local function telescope_config()
    local telescope = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>ff", telescope.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<Leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
    vim.keymap.set("n", "<Leader>fb", telescope.buffers, { desc = "Telescope buffers" })
    vim.keymap.set("n", "<Leader>fh", telescope.help_tags, { desc = "Telescope help tags" })
end
telescope_config()

local function nvimtree_config()
    local api = require("nvim-tree.api")
    vim.keymap.set("n", "<Leader>nt", api.tree.toggle)
    vim.keymap.set("n", "<Leader>nf", api.tree.focus)
end
nvimtree_config()

vim.keymap.set("n", "<Leader>'", ":lua vim.diagnostic.open_float()<CR>")

