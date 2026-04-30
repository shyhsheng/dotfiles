return {
    {
        "chentoast/marks.nvim",
        event = "BufReadPost",
        opts = {
            default_mappings = true,
            builtin_marks = { ".", "<", ">", "^" },
            cyclic = true,
            force_write_shada = false,
            refresh_interval = 250,
            sign_priority = 10,

            excluded_filetypes = {
                "snacks_picker",
                "snacks_dashboard",
                "snacks_notif",
                "neo-tree",
                "NvimTree",
                "help",
                "qf",
                "Trouble",
                "lazy",
                "mason",
                "notify",
                "toggleterm",
            },

            bookmark_0 = {
                sign = "⚑",
                virt_text = "Bookmark",
                annotate = false,
            },

            mappings = {
                next = "<F2>",
                prev = "<F14>",
            },
            -- 'a              Move to specific mark
            -- mx              Set mark x
            -- m,              Set the next available alphabetical (lowercase) mark
            -- m;              Toggle the next available mark at the current line
            -- dmx             Delete mark x
            -- dm-             Delete all marks on the current line
            -- dm<space>       Delete all marks in the current buffer
            -- m]              Move to next mark
            -- m[              Move to previous mark
            -- m:              Preview mark. This will prompt you for a specific mark to
            --                 preview; press <cr> to preview the next mark.
            --
            -- m[0-9]          Add a bookmark from bookmark group[0-9].
            -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
            -- m}              Move to the next bookmark having the same type as the bookmark under
            --                 the cursor. Works across buffers.
            -- m{              Move to the previous bookmark having the same type as the bookmark under
            --                 the cursor. Works across buffers.
            -- dm=             Delete the bookmark under the cursor.
        },
    },
}
