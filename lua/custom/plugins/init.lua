-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      local connections_file = os.getenv("HOME") .. "/.local/share/dbee/connections.json"
      local sources = {}

      -- Only add FileSource if connections.json exists
      if vim.fn.filereadable(connections_file) == 1 then
        table.insert(sources, require("dbee.sources").FileSource:new(connections_file))
      end

      require("dbee").setup({
        sources = sources,
      })

      -- Auto-execute queries on save for dbee scratchpads
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.sql",
        callback = function()
          -- Check if this is a dbee scratchpad by looking for dbee in the buffer name or filetype
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname:match("dbee") or vim.bo.filetype == "sql" then
            -- Get the entire buffer content like run_file does
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local query = table.concat(lines, "\n")

            -- Execute the query (equivalent to pressing BB in normal mode)
            if query and query ~= "" then
              require("dbee").execute(query)
            end
          end
        end,
        desc = "Auto-execute dbee queries on save"
      })
    end,
  },
}
