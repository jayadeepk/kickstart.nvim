-- Custom Keymaps
-- Personal keymaps and terminal shortcuts

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', ';;', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

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

-- Split with terminal
vim.keymap.set('n', '<leader>th', function()
  vim.cmd 'split | terminal'
  vim.cmd 'startinsert'
end, { desc = '[T]erminal [H]orizontal split' })

vim.keymap.set('n', '<leader>tv', function()
  vim.cmd 'vsplit | terminal'
  vim.cmd 'startinsert'
end, { desc = '[T]erminal [V]ertical split' })

-- Terminal in direction (hjkl)
local function open_terminal_left()
  vim.cmd 'leftabove vsplit'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end

local function open_terminal_right()
  vim.cmd 'rightbelow vsplit'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end

local function open_terminal_up()
  vim.cmd 'aboveleft split'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end

local function open_terminal_down()
  vim.cmd 'rightbelow split'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end

-- Normal mode
vim.keymap.set('n', '<M-h>', open_terminal_left, { desc = 'Open terminal in left split' })
vim.keymap.set('n', '<M-l>', open_terminal_right, { desc = 'Open terminal in right split' })
vim.keymap.set('n', '<M-k>', open_terminal_up, { desc = 'Open terminal in upper split' })
vim.keymap.set('n', '<M-j>', open_terminal_down, { desc = 'Open terminal in lower split' })

-- Terminal mode
vim.keymap.set('t', '<M-h>', function()
  vim.cmd 'stopinsert'
  open_terminal_left()
end, { desc = 'Open terminal in left split' })

vim.keymap.set('t', '<M-l>', function()
  vim.cmd 'stopinsert'
  open_terminal_right()
end, { desc = 'Open terminal in right split' })

vim.keymap.set('t', '<M-k>', function()
  vim.cmd 'stopinsert'
  open_terminal_up()
end, { desc = 'Open terminal in upper split' })

vim.keymap.set('t', '<M-j>', function()
  vim.cmd 'stopinsert'
  open_terminal_down()
end, { desc = 'Open terminal in lower split' })

-- Switch to previous buffer from terminal mode
vim.keymap.set('t', '<C-^>', function()
  vim.cmd 'stopinsert'
  vim.cmd 'buffer #'
end, { desc = 'Switch to previous buffer from terminal' })

-- Scroll half page up/down from terminal mode
vim.keymap.set('t', '<C-u>', '<C-\\><C-n><C-u>', { desc = 'Scroll half page up from terminal' })

-- File finder from terminal mode
vim.keymap.set('t', '<C-p>', function()
  vim.cmd 'stopinsert'
  require('telescope.builtin').find_files()
end, { desc = 'Find files from terminal' })

-- Quit all in normal, insert, and terminal modes
vim.keymap.set('n', '<C-q>', '<cmd>qa<CR>', { desc = 'Quit all' })
vim.keymap.set('i', '<C-q>', '<Esc><cmd>qa<CR>', { desc = 'Quit all from insert mode' })
vim.keymap.set('t', '<C-q>', '<C-\\><C-n><cmd>qa<CR>', { desc = 'Quit all from terminal' })

-- Open terminal in vertical split and switch to insert mode
vim.keymap.set('n', '<C-t>', '<cmd>vsplit | terminal<CR>i', { desc = 'Open terminal in vertical split and enter insert mode' })

-- Open terminal in vertical split and run AI command, then horizontal split with normal terminal
vim.keymap.set('n', '<C-Space>', function()
  local ai_cmd
  if vim.fn.getenv 'NVIM_AI_TOOL' == 'codex' then
    ai_cmd = 'codex --dangerously-bypass-approvals-and-sandbox'
  else
    ai_cmd = 'source ~/.zshrc && nvm use 24 && claude --dangerously-skip-permissions'
  end
  vim.cmd('vsplit | terminal ' .. ai_cmd)
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

-- Close current buffer with Ctrl+w
vim.keymap.set('n', '<C-w>', '<cmd>q<CR>', { desc = 'Close current buffer' })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><cmd>q<CR>', { desc = 'Close current buffer from terminal' })

-- Database UI (vim-dadbod)
vim.keymap.set('n', '<leader>db', '<cmd>DBUIToggle<CR>', { desc = '[D]atabase [B]rowser toggle' })
vim.keymap.set('n', '<leader>da', '<cmd>DBUIAddConnection<CR>', { desc = '[D]atabase [A]dd connection' })
vim.keymap.set('n', '<leader>df', '<cmd>DBUIFindBuffer<CR>', { desc = '[D]atabase [F]ind buffer' })

-- Toggle diagnostics
vim.keymap.set('n', '<leader>td', function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.disable()
    print 'Diagnostics disabled'
  else
    vim.diagnostic.enable()
    print 'Diagnostics enabled'
  end
end, { desc = '[T]oggle [D]iagnostics' })

-- Toggle between light and dark mode
vim.keymap.set('n', '<leader>tt', function()
  if vim.o.background == 'dark' then
    vim.o.background = 'light'
  else
    vim.o.background = 'dark'
  end
end, { desc = '[T]oggle [T]heme (light/dark mode)' })

-- Copy relative file path to clipboard
vim.keymap.set('n', '<leader>cp', function()
  local file_path = vim.fn.expand '%:p'
  local cwd = vim.fn.getcwd()
  local relative_path

  if file_path:sub(1, #cwd) == cwd then
    relative_path = file_path:sub(#cwd + 2)
  else
    relative_path = file_path
  end

  vim.fn.setreg('+', relative_path)
  print('Copied: ' .. relative_path)
end, { desc = '[C]opy relative file [P]ath' })

-- Send current relative file path to Claude Code terminal
vim.keymap.set('n', '<leader>cl', function()
  local file_path = vim.fn.expand '%:p'
  local cwd = vim.fn.getcwd()
  local relative_path

  if file_path:sub(1, #cwd) == cwd then
    relative_path = file_path:sub(#cwd + 2)
  else
    relative_path = file_path
  end

  local text = ' @' .. relative_path .. ' '

  -- Find Claude terminal buffer
  local terminal_found = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      -- Look for Claude terminal (contains both "term://" and "claude")
      if buf_name:match 'term://' and buf_name:match 'claude' then
        -- Get the channel ID for the terminal
        local channel = vim.api.nvim_buf_get_option(buf, 'channel')
        if channel and channel ~= 0 then
          vim.fn.chansend(channel, text)
          print('Sent to Claude: ' .. text)
          terminal_found = true
          break
        end
      end
    end
  end

  if not terminal_found then
    print 'Claude terminal not found'
  end
end, { desc = '[C]laude send relative file path' })

-- Toggle comments with Ctrl+/
vim.keymap.set('n', '<C-/>', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle line comment' })

vim.keymap.set('v', '<C-/>', function()
  require('Comment.api').toggle.linewise(vim.fn.visualmode())
end, { desc = 'Toggle line comment' })
