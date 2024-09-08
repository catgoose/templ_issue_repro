# templ issues

Install templ and gopls

```bash
go install github.com/a-h/templ/cmd/templ@latest
go install golang.org/x/tools/gopls@latest
```

Run neovim with

```bash
nvim --clean -u templ.lua views/index.templ
```

use `gd` keybinding over `Content` in the Index template

error:

```lua
Error executing vim.schedule lua callback: /usr/local/share/nvim/runtime/lua/vim/lsp/util.lua:17
98: index out of range
stack traceback:
        [C]: in function '_str_byteindex_enc'
        /usr/local/share/nvim/runtime/lua/vim/lsp/util.lua:1798: in function 'locations_to_items
'
        /usr/local/share/nvim/runtime/lua/vim/lsp/handlers.lua:436: in function 'handler'
        /usr/local/share/nvim/runtime/lua/vim/lsp/client.lua:687: in function ''
        vim/_editor.lua: in function <vim/_editor.lua:0>
Press ENTER or type command to continue
```
