-- Custom Keymaps
-- Personal keymaps and terminal shortcuts

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Terminal mode window navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window from terminal' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window from terminal' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window from terminal' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window from terminal' })

-- Open terminal in vertical split and switch to insert mode
vim.keymap.set('n', '<C-t>', '<cmd>vsplit | terminal<CR>i', { desc = 'Open terminal in vertical split and enter insert mode' })

-- Open terminal in vertical split and run claude command, then horizontal split with normal terminal
vim.keymap.set('n', '<C-Space>', function()
  vim.cmd 'vsplit | terminal source ~/.zshrc && nvm use 22 && claude --dangerously-skip-permissions'
  -- Resize vertical split: left 60%, right 40%
  vim.cmd('vertical resize ' .. math.floor(vim.o.columns * 0.4))
  vim.cmd 'split | terminal'
  -- Resize horizontal split: top 60%, bottom 40%
  vim.cmd('resize ' .. math.floor(vim.o.lines * 0.2))
  vim.cmd 'wincmd k' -- Move focus back up to claude terminal
  vim.cmd 'startinsert'
end, { desc = 'Open claude in vertical split with normal terminal below' })

-- Window resizing with Ctrl + arrow keys
vim.keymap.set('n', '<C-Left>', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<C-w>>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-Up>', '<C-w>+', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<C-w>-', { desc = 'Decrease window height' })
