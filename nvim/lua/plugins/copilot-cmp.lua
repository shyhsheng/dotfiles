return {
    {
        "zbirenbaum/copilot.lua",
        opts = {
            suggestion = {
                enabled = false, -- 關掉 inline ghost text
            },
            panel = {
                enabled = false,
            },
        },
    },

    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },
}
