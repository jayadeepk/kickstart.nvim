-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "tpope/vim-dadbod",
    lazy = true,
    cmd = "DB",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      -- Set the save location for dadbod queries and connections
      vim.g.db_ui_save_location = os.getenv("HOME") .. "/.local/share/db_ui"
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = {
      "tpope/vim-dadbod",
    },
    lazy = true,
    ft = { "sql", "mysql", "plsql" },
  },
}
