-- Custom Keymaps
-- Personal keymaps and terminal shortcuts

-- Open terminal in vertical split and switch to insert mode
vim.keymap.set('n', '<C-t>', '<cmd>vsplit | terminal<CR>i', { desc = 'Open terminal in vertical split and enter insert mode' })

-- Open terminal in vertical split and run claude command
vim.keymap.set('n', '<C-Space>', '<cmd>vsplit | terminal source ~/.zshrc && nvm use 22 && claude --dangerously-skip-permissions<CR>i', { desc = 'Open claude in vertical split' })