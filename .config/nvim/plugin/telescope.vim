noremap <leader>p :Telescope find_files<cr>
noremap <leader>b :Telescope buffers<cr>
noremap <leader>h :Telescope oldfiles <cr>
noremap <leader><S-p> :Telescope live_grep<cr>
noremap <leader>s :Telescope grep_string<cr>
noremap <leader>f :Telescope file_browser<cr>
noremap <leader>l :Telescope resume<cr>

lua << EOF
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

EOF

