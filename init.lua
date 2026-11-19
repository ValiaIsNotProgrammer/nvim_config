vim.g.mapleader = ' '
vim.opt.timeoutlen=1000

-- Current plugins use Lua/Vimscript; these remote-plugin hosts are unnecessary.
-- This does not disable language servers or project Python environments.
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

-- Basic
require("core.plugins")
require("core.configs")
require("core.mappings") 

-- Functions 
_G.dump = require("core.functions").dump
