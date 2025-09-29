-- lsp.lua
-- This file sets up Mason and connects LSP servers to Neovim


-- 1. Ensure Mason and LSPConfig are loaded
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "ts_ls", "lua_ls" }, -- add servers you want
    automatic_installation = true,
})



local lspconfig = require("lspconfig")

-- 2. Common keymaps for LSP functions
local on_attach = function(_, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end


-- 3. Setup servers
local servers = { "pyright", "ts_ls", "lua_ls" }

for _, server in ipairs(servers) do
    lspconfig[server].setup({
        on_attach = on_attach,
    })
end
