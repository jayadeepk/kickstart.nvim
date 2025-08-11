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
          
          -- Make statusline blend with window background in light mode
          vim.cmd [[
            highlight StatusLine guifg=#3760bf guibg=#e1e2e7 gui=NONE
            highlight StatusLineNC guifg=#8990b3 guibg=#d0d5e3 gui=NONE
            highlight MiniStatuslineFilename guifg=#3760bf guibg=#e1e2e7
            highlight MiniStatuslineInactive guifg=#8990b3 guibg=#d0d5e3
            highlight MiniStatuslineDevinfo guifg=#3760bf guibg=#e1e2e7
            highlight MiniStatuslineModeNormal guifg=#3760bf guibg=#e1e2e7
            highlight MiniStatuslineModeInsert guifg=#3760bf guibg=#e1e2e7
            highlight MiniStatuslineModeVisual guifg=#3760bf guibg=#e1e2e7
            highlight MiniStatuslineModeReplace guifg=#3760bf guibg=#e1e2e7
            highlight MiniStatuslineModeCommand guifg=#3760bf guibg=#e1e2e7
            highlight MiniStatuslineModeOther guifg=#3760bf guibg=#e1e2e7
          ]]
        else
          vim.cmd.colorscheme 'tokyonight-night'
          
          -- Reset cursor colors for dark mode (theme defaults are usually fine)
          vim.cmd [[
            highlight Cursor guifg=black guibg=white
            highlight iCursor guifg=black guibg=white
          ]]
          
          -- Make statusline blend with window background in dark mode
          vim.cmd [[
            highlight StatusLine guifg=#7aa2f7 guibg=#1a1b26 gui=NONE
            highlight StatusLineNC guifg=#565f89 guibg=#16161e gui=NONE
            highlight MiniStatuslineFilename guifg=#7aa2f7 guibg=#1a1b26
            highlight MiniStatuslineInactive guifg=#565f89 guibg=#16161e
            highlight MiniStatuslineDevinfo guifg=#7aa2f7 guibg=#1a1b26
            highlight MiniStatuslineModeNormal guifg=#7aa2f7 guibg=#1a1b26
            highlight MiniStatuslineModeInsert guifg=#7aa2f7 guibg=#1a1b26
            highlight MiniStatuslineModeVisual guifg=#7aa2f7 guibg=#1a1b26
            highlight MiniStatuslineModeReplace guifg=#7aa2f7 guibg=#1a1b26
            highlight MiniStatuslineModeCommand guifg=#7aa2f7 guibg=#1a1b26
            highlight MiniStatuslineModeOther guifg=#7aa2f7 guibg=#1a1b26
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