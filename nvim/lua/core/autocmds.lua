vim.api.nvim_create_augroup("personal", { clear = true })

vim.api.nvim_create_autocmd(
    { "BufEnter", "BufWinEnter" },
    {
        pattern = { "*.pp" },
        command = "set syntax=ruby",
        group = "personal"
    }
)
