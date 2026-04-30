-- ~/.config/nvim/lua/plugins/illuminate.lua
return {
    {
        "RRethy/vim-illuminate",
        opts = {
            under_cursor = true,
            providers = {
                "lsp",
                "treesitter",
            },
        },
    },
}
