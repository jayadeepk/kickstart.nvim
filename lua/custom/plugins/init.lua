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
    config = function()
      -- Enable line wrapping for SQL query editor, but not for results
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "sql,mysql,plsql",
        callback = function(args)
          -- Check if this is a results buffer (dbout) or editor buffer
          local buf_name = vim.api.nvim_buf_get_name(args.buf)
          if buf_name:match("dbout") or buf_name:match("query_output") then
            vim.opt_local.wrap = false
          else
            -- This is the editor buffer, enable wrapping
            vim.opt_local.wrap = true
          end
        end,
      })
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
  {
    "numToStr/comment.nvim",
    opts = {},
  },
}
