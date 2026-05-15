return {
    "akinsho/bufferline.nvim",
    opts = {
        highlights = {
            -- 這裡控制「當前選中」的 buffer 樣式
            buffer_selected = {
                fg = "#ff9e64", -- 文字顏色 (例如：亮橘色)
                bg = "#1f2335", -- 背景顏色 (需符合你的 colorscheme 或是設為透明)
                bold = true,
                italic = false,
            },
            -- 這裡控制選中 buffer 的標籤/指示條顏色 (通常是選中時左邊或下方的色條)
            indicator_selected = {
                fg = "#ff9e64",
                bg = "#1f2335",
            },
            -- 如果你有開啟修改狀態，也可以改選中且被修改過的顏色
            modified_selected = {
                fg = "#f7768e",
                bg = "#1f2335",
            },
        },
    },
}
