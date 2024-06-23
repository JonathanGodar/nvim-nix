if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('which-key').setup()
require('nvim-surround').setup()
require('oil').setup({
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-w>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" }
    -- ["<C-S>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in a horizontal split" },
    -- ["<M-v>"] = { "actions.select", opts = { vertical = true } },
  }
})

local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup {}
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {}

lspconfig.nil_ls.setup {}
lspconfig.lua_ls.setup {
  on_init = function (client)
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
          }
        }
      })
  end
}
