# templ issues

Install templ and gopls

```bash
go install github.com/a-h/templ/cmd/templ@latest
go install golang.org/x/tools/gopls@latest
```

Have `htmxlsp` in path

Run neovim with

```bash
nvim --clean -u templ.lua views/index.templ
```

Do `K` over htmx attributes:

![Image](https://github.com/user-attachments/assets/277895ef-6446-4c5f-a320-f8030fc8138e)

Now do `K` over html or templ symbols, observe that no hover occurs

Disable htmx lsp in `templ.lua`:

```lua
  local templ_opts = {
    cmd = {
      "templ",
      "lsp",
      "-http=localhost:7474",
      string.format("-log=%s/templ.log", vim.fn.expand("~")),
    },
    filetypes = filetypes,
    root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
    settings = {},
  }
  lspconfig.html.setup({
    filetypes = filetypes,
  })
  lspconfig.templ.setup(templ_opts)
  -- lspconfig.htmx.setup({
  --   filetypes = filetypes,
  -- })
```

Now do `K` over HTML and Templ symbols:

![Image](https://github.com/user-attachments/assets/13fc78a1-a12f-44f6-bb9d-49de9cd34a93)

![Image](https://github.com/user-attachments/assets/9d0ee887-92db-40d8-a944-b3e177272590)
