return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.lsp.config("pylsp", {
      -- Resolve the server separately for each project, not from Neovim's cwd.
      cmd = function(dispatchers, config)
        local local_pylsp = config.root_dir and (config.root_dir .. "/.venv/bin/pylsp")
        local executable = local_pylsp and vim.fn.executable(local_pylsp) == 1
          and local_pylsp or "pylsp"
        return vim.lsp.rpc.start({ executable }, dispatchers, {
          cwd = config.root_dir,
          env = config.cmd_env,
        })
      end,
      root_markers = { { ".venv", "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", "Pipfile", ".git" } },
      before_init = function(_, config)
        local python = config.root_dir and (config.root_dir .. "/.venv/bin/python")
        if python and vim.fn.executable(python) == 1 then
          local plugins = config.settings.pylsp.plugins
          plugins.jedi = vim.tbl_deep_extend("force", plugins.jedi or {}, {
            environment = python,
          })
        end
      end,
      settings = {
        pylsp = {
          plugins = {
            pyflakes={enabled=true},
            pylsp_mypy={enabled=true},
            pycodestyle={
                enabled=true,
                ignore={'W391'},
                maxLineLength=120
            }
          -- mypy = {
          --     enabled = true,
          --     strict = true
          --   },
          },
        },
      },
    })
    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          analyses = { unusedparams = true },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = { enable = true, experimental = { enable = true } },
        },
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { buffer = ev.buf }

        local map = vim.keymap.set
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "<Leader>ls", vim.lsp.buf.signature_help, opts)
        map("n", "<Leader>lr", vim.lsp.buf.rename, opts)
        map({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts)
        map("n", "<Leader>lf", function() vim.lsp.buf.format { async = true } end, opts)
      end,
    })

    vim.keymap.set("n", "<leader>lD", vim.diagnostic.open_float)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist)

    vim.lsp.enable({ "pylsp", "clangd", "intelephense", "ts_ls", "prismals", "cssls", "gopls", "rust_analyzer" })
  end,
}

