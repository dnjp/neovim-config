vim.opt.termguicolors = true

function _G.load_theme()

  vim.cmd [[
    function! s:base16_customize() abort
      highlight! SignColumn guibg=none ctermbg=none
      highlight LineNr guibg=bg ctermbg=none
      highlight StatusLine ctermbg=none guibg=bg
      execute 'highlight! GitSignsChange guibg=bg guifg=#' . g:base16_gui0D
      execute 'highlight! GitSignsDelete guibg=bg guifg=#' . g:base16_gui08
      execute 'highlight! GitSignsAdd guibg=bg guifg=#' . g:base16_gui0B
      execute 'highlight! VertSplit guibg=none guifg=#' . g:base16_gui03
    endfunction

    augroup on_change_colorschema
      autocmd!
      autocmd ColorScheme * call s:base16_customize()
    augroup END
  ]]

  vim.cmd [[
    if filereadable(expand("~/.vimrc_background"))
      highlight clear
      let base16colorspace=256
      source ~/.vimrc_background
    endif
  ]]

end

-- load theme on startup
_G.load_theme()

-- define utility functions for watching file changed
local w = vim.loop.new_fs_event()
local function on_change(err, fname, status)
  _G.load_theme()
end

function watch_file(fname)
  local fullpath = vim.api.nvim_call_function( 'fnamemodify', {fname, ':p'})
  w:start(fullpath, {}, vim.schedule_wrap(function(...) on_change(...) end))
end

-- -- when the vimrc_backround changes, load the theme
watch_file("~/.vimrc_background")
