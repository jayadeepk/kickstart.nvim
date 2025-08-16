return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  keys = {
    { '<leader>dv', '<cmd>DiffviewOpen<cr>', desc = 'Open [D]iff[V]iew' },
    { '<leader>dc', '<cmd>DiffviewClose<cr>', desc = '[D]iffview [C]lose' },
    { '<leader>dh', '<cmd>DiffviewFileHistory %<cr>', desc = '[D]iffview File [H]istory' },
    { '<leader>df', '<cmd>DiffviewToggleFiles<cr>', desc = '[D]iffview Toggle [F]iles' },
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = 'diff2_horizontal',
      },
      merge_tool = {
        layout = 'diff3_horizontal',
        disable_diagnostics = true,
      },
      file_history = {
        layout = 'diff2_horizontal',
      },
    },
    file_panel = {
      listing_style = 'tree',
      tree_options = {
        flatten_dirs = true,
        folder_statuses = 'only_folded',
      },
    },
    keymaps = {
      view = {
        ['q'] = '<cmd>DiffviewClose<cr>',
        ['<tab>'] = '<cmd>DiffviewToggleFiles<cr>',
      },
      file_panel = {
        ['q'] = '<cmd>DiffviewClose<cr>',
        ['<cr>'] = 'select_entry',
        ['o'] = 'select_entry',
        ['<tab>'] = '<cmd>DiffviewToggleFiles<cr>',
      },
    },
  },
}