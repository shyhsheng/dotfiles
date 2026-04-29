return {
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            local cmp = require("cmp")
            local has_luasnip, luasnip = pcall(require, "luasnip")

            opts.preselect = cmp.PreselectMode.None
            opts.completion = opts.completion or {}
            opts.completion.completeopt = "menu,menuone,noinsert,noselect"

            opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({
                            behavior = cmp.SelectBehavior.Insert,
                        })
                    elseif has_luasnip and luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({
                            behavior = cmp.SelectBehavior.Insert,
                        })
                    elseif has_luasnip and luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),

                ["<C-e>"] = cmp.mapping.close(),
            })

            opts.window = {
                completion = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = table.concat({
                        "Normal:CmpPmenu",
                        "FloatBorder:CmpBorder",
                        "CursorLine:CmpSel",
                        "Search:None",
                    }, ","),
                }),
                documentation = cmp.config.window.bordered({
                    border = "rounded",
                    winhighlight = table.concat({
                        "Normal:CmpDoc",
                        "FloatBorder:CmpDocBorder",
                        "CursorLine:CmpSel",
                        "Search:None",
                    }, ","),
                }),
            }

            local function apply_cmp_highlights()
                vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "#11131a" })
                vim.api.nvim_set_hl(0, "CmpDoc", { bg = "#11131a" })

                vim.api.nvim_set_hl(0, "CmpBorder", {
                    fg = "#9aa5ce",
                    bg = "#11131a",
                })

                vim.api.nvim_set_hl(0, "CmpDocBorder", {
                    fg = "#9aa5ce",
                    bg = "#11131a",
                })

                vim.api.nvim_set_hl(0, "CmpSel", {
                    bg = "#3b4261",
                    fg = "#ffffff",
                    bold = true,
                })

                vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {
                    fg = "#7aa2f7",
                    bold = true,
                })

                vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {
                    fg = "#7aa2f7",
                    bold = true,
                })

                vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#bb9af7" })
                vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#bb9af7" })
                vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9ece6a" })
                vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#9ece6a" })
                vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#f7768e" })
                vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#e0af68" })
                vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#7dcfff" })
            end

            apply_cmp_highlights()

            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = apply_cmp_highlights,
            })

            return opts
        end,
    },
}
