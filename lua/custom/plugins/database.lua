return {
  {
    'tpope/vim-dadbod',
    cmd = { 'DB' },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = { 'tpope/vim-dadbod' },
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
    keys = {
      { '<leader>du', '<cmd>DBUIToggle<cr>', desc = '[D]atabase [U]I Toggle' },
      { '<leader>df', '<cmd>DBUIFindBuffer<cr>', desc = '[D]atabase [F]ind Buffer' },
      { '<leader>dr', '<cmd>DBUIRenameBuffer<cr>', desc = '[D]atabase [R]ename Buffer' },
      { '<leader>dl', '<cmd>DBUILastQueryInfo<cr>', desc = '[D]atabase [L]ast Query Info' },
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_show_database_icon = vim.g.have_nerd_font
      vim.g.db_ui_force_echo_notifications = 1
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_use_nvim_notify = 1
      
      vim.g.db_ui_table_helpers = {
        mysql = {
          List = 'SELECT * FROM {table} LIMIT 200;',
          Indexes = 'SHOW INDEX FROM {table};',
          Describe = 'DESCRIBE {table};',
        },
      }
    end,
  },
}