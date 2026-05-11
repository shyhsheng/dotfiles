return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ["*"] = {
                    keys = {
                        { "<C-k>", false, mode = "i" },
                        {
                            "<C-f>",
                            vim.lsp.buf.signature_help,
                            mode = "i",
                            desc = "Signature Help",
                        },
                    },
                },
            },
        },
    },
}
