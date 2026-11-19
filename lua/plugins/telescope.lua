return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", function()
      require("telescope").extensions.live_grep_args.live_grep_args()
    end, desc = "Live grep with filters" },
  },
  config = function()
    local actions = require("telescope.actions")
    local action_layout = require("telescope.actions.layout")

    require("telescope").setup {
      defaults = {
        vimgrep_arguments = {
          'rg', '--hidden', '--max-columns=200',
          '--no-heading', '--with-filename', '--line-number',
          '--column', '--smart-case',
          '--glob', '!.git/*',
          '--glob', '!.venv/*',
          '--glob', '!node_modules/*',
          '--glob', '!dist/*',
          '--glob', '!build/*',
          '--glob', '!.idea/*',
          '--glob', '!.vscode/*',
          '--glob', '!__pycache__/*',
        },
        mappings = {
          i = {
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
          },
          n = {
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
          },
        },
      },
    }
    require("telescope").load_extension("live_grep_args")
  end,
}

