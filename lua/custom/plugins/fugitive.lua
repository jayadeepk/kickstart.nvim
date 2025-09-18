-- Git integration with vim-fugitive
return {
  'tpope/vim-fugitive',
  config = function()
    -- Basic keymaps for fugitive
    local map = vim.keymap.set
    
    map('n', '<leader>gs', '<cmd>Git<cr>', { desc = '[G]it [s]tatus' })
    map('n', '<leader>gl', '<cmd>Git log<cr>', { desc = '[G]it [l]og' })
    map('n', '<leader>gb', '<cmd>Git blame<cr>', { desc = '[G]it [b]lame' })
    map('n', '<leader>gd', '<cmd>Gdiffsplit<cr>', { desc = '[G]it [d]iff' })
    map('n', '<leader>gc', '<cmd>Git commit<cr>', { desc = '[G]it [c]ommit' })
    
    -- Map 'q' to quit in fugitive buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fugitive*", "git" },
      callback = function()
        vim.keymap.set("n", "q", ":q<CR>", { buffer = true, silent = true })
      end,
    })
  end,
}