-- Theme synchronization plugin for Windows 11
return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      -- Function to detect Windows theme
      local function get_windows_theme()
        local handle = io.popen('powershell.exe -ExecutionPolicy Bypass -File ~/.config/nvim/scripts/get_windows_theme.ps1 2>/dev/null')
        if not handle then
          return 'dark' -- fallback
        end
        
        local result = handle:read("*a")
        handle:close()
        
        if result then
          result = result:gsub("%s+", "") -- trim whitespace
          return result == 'light' and 'light' or 'dark'
        end
        
        return 'dark' -- fallback
      end

      -- Function to apply theme based on Windows setting
      local function sync_theme()
        local windows_theme = get_windows_theme()
        
        -- Configure tokyonight
        require('tokyonight').setup {
          styles = {
            comments = { italic = false },
          },
          dim_inactive = true,
        }
        
        -- Set colorscheme based on Windows theme
        if windows_theme == 'light' then
          vim.cmd.colorscheme 'tokyonight-day'
          -- Fix cursor colors for light mode
          vim.cmd [[
            highlight Cursor guifg=white guibg=black
            highlight iCursor guifg=white guibg=black
            highlight CursorLine guibg=#e9e9ec
            highlight Visual guibg=#c8c8ce
          ]]
        else
          vim.cmd.colorscheme 'tokyonight-night'
          -- Reset cursor colors for dark mode (theme defaults are usually fine)
          vim.cmd [[
            highlight Cursor guifg=black guibg=white
            highlight iCursor guifg=black guibg=white
          ]]
        end
        
        -- Set terminal cursor colors for better visibility
        vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-iCursor,r-cr:hor20,o:hor50"
      end

      -- Apply theme on startup
      sync_theme()

      -- Create user command to manually sync theme
      vim.api.nvim_create_user_command('SyncTheme', sync_theme, {
        desc = 'Sync Neovim theme with Windows 11 theme'
      })

      -- Auto-sync theme periodically (every 30 seconds)
      local function setup_auto_sync()
        local timer = vim.uv.new_timer()
        if timer then
          timer:start(30000, 30000, vim.schedule_wrap(sync_theme))
        end
      end

      -- Setup auto-sync after a short delay to avoid startup issues
      vim.defer_fn(setup_auto_sync, 1000)
    end,
  }
}