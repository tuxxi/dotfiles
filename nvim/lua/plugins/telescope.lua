require('telescope').setup{
    extensions = {
        ["ui-select"] = {},
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
            sort_lastused = true,
        },
    }
}

require('telescope').load_extension('ui-select')
