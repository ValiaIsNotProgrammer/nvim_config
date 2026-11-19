
-- Registers
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })
vim.keymap.set("n", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true })
vim.keymap.set("x", "p", '"_dP', { noremap = true, silent = true })

-- Tabs
vim.keymap.set('n', 'H', ':tabp<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'L', ':tabn<CR>', { noremap = true, silent = true })

-- Buffer
vim.keymap.set('n', '<leader>w', ':w<CR>')


-- Navigation
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set("n", "<leader>td", function()
  vim.lsp.buf.definition({
    on_list = function(options)
      if #options.items == 0 then
        return
      end
      vim.cmd("tabnew")
      vim.fn.setqflist({}, " ", options)
      vim.cmd("cfirst")
    end,
  })
end, { desc = "Go to definition in new tab" })
vim.keymap.set('n', '<leader><leader>', '<C-w>')
vim.keymap.set('n', '<leader>jo', ':put _<CR>', { noremap = true, silent = true })   -- вставить строку ниже
vim.keymap.set('n', '<leader>jO', ':put! _<CR>', { noremap = true, silent = true })  -- вставить строку выше

-- Highlights
vim.keymap.set('n', '<leader>noh', ':noh<CR>')

-- Comments
vim.keymap.set('n', '<leader>/', 'gcc')

-- Keyboard
local function escape(str)
  -- Эти символы должны быть экранированы, если встречаются в langmap
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
vim.opt.langmap = vim.fn.join({
  escape(ru_shift) .. ';' .. escape(en_shift),
  escape(ru) .. ';' .. escape(en),
}, ',')
-- Plugins

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree left reveal<CR>')
vim.keymap.set('n', '<leader>o', ':Neotree float git_status<CR>')

-- Telescope
local status, builtin = pcall(require, "telescope.builtin")
local action_layout = require("telescope.actions.layout")
-- vim.keymap.set('n', '<C-p>', action_layout.toggle_preview)
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', function()
  require('telescope').extensions.live_grep_args.live_grep_args()
end, { desc = 'Live grep with filters' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- Yanky
-- vim.keymap.set("n", "<leader>p", "<cmd>Telescope yank_history<cr>", { desc = "Paste from yank history" })


return M 
