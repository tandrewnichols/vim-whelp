if exists("g:loaded_whelp") || &cp | finish | endif

let g:loaded_whelp = 1

let g:whelp_VERSION = '1.0.0'

if !has_key(g:, 'whelp_file') || empty(g:whelp_file)
  let g:whelp_file = $HOME . "/.vim/whelp.txt"
endif

augroup Whelp
  au!
  au CmdlineLeave * call whelp#save()
  exec "au BufEnter" g:whelp_file "nnoremap <buffer> K :call whelp#reopen()\<CR>"
augroup END

command! -nargs=0 Whelp :call whelp#show()
command! -nargs=0 -bang VWhelp :call whelp#show('vsp', <bang>0)
command! -nargs=0 -bang SWhelp :call whelp#show('sp', <bang>0)
command! -nargs=0 TWhelp :call whelp#show('tabe')
