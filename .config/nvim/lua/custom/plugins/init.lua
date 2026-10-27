-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end

-- Install plugins
vim.pack.add {
  'https://github.com/folke/noice.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/rcarriga/nvim-notify',
}

-- Setup nvim-notify as the notification backend
-- See :help notify
require('notify').setup {
  background_colour = '#000000',
}
vim.notify = require('notify')

-- Setup noice.nvim (replaces messages, cmdline, and popupmenu UI)
-- See :help noice, https://github.com/folke/noice.nvim
require('noice').setup {
  lsp = {
    override = {
      -- Use noice's markdown renderer for better LSP hover docs
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      -- Only enable the cmp override if using nvim-cmp (not blink.cmp)
      ['cmp.entry.get_documentation'] = false,
    },
  },
  presets = {
    bottom_search = true, -- classic bottom cmdline for search
    command_palette = true, -- cmdline + popupmenu together
    long_message_to_split = true, -- long messages go to a split
    inc_rename = false,
    lsp_doc_border = false,
  },
}
