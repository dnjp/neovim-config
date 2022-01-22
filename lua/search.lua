require'fzf-lua'.setup {
    winopts = {
        preview = {
            scrollbar = false,
            winopts = {                       -- builtin previewer window options
                number            = false,
                relativenumber    = false,
                cursorline        = true,
                cursorlineopt     = 'both',
                cursorcolumn      = false,
                signcolumn        = 'no',
                list              = false,
                foldenable        = false,
                foldmethod        = 'manual',
            },
        },
    },
    fzf_colors = {
        ["fg"]          = { "fg", "CursorLine" },
        ["bg"]          = { "bg", "Normal" },
        ["hl"]          = { "fg", "Comment" },
        ["fg+"]         = { "fg", "Normal" },
        ["bg+"]         = { "bg", "CursorLine" },
        ["hl+"]         = { "fg", "Statement" },
        ["info"]        = { "fg", "PreProc" },
        ["prompt"]      = { "fg", "Conditional" },
        ["pointer"]     = { "fg", "Exception" },
        ["marker"]      = { "fg", "Keyword" },
        ["spinner"]     = { "fg", "Label" },
        ["header"]      = { "fg", "Comment" },
        ["gutter"]      = { "bg", "Normal" },
    },
}
