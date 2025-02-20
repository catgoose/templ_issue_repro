vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

local config = function()
  local lspconfig = require("lspconfig")

  local function go_on_attach(client, _)
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
  end

  local gopls_opts = {
    on_attach = go_on_attach,
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        staticcheck = true,
        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
        semanticTokens = true,
        gofumpt = true,
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          fieldalignment = true,
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
      },
    },
  }
  lspconfig.gopls.setup(gopls_opts)

  local templ_opts = {
    cmd = {
      "templ",
      "lsp",
      "-http=localhost:7474",
      string.format("-log=%s/templ.log", vim.fn.expand("~")),
    },
    filetypes = { "templ" },
    root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
    settings = {},
  }
  lspconfig.templ.setup(templ_opts)
  lspconfig.htmx.setup({
    filetypes = { "templ" },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(event)
      local bufopts = { noremap = true, silent = true, buffer = event.buf }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    end,
  })
end

require("lazy.minit").repro({
  spec = {
    "neovim/nvim-lspconfig",
    config = config,
    -- lazy = false,
  },
})
