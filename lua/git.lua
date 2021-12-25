vim.cmd "let $GIT_EDITOR = 'nvr -cc split --remote-wait +\"set bufhidden=wipe\"'"
vim.cmd 'autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete'

