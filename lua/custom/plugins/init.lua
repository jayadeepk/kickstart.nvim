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
    end,
  },
}
