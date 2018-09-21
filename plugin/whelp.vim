if exists("g:loaded_whelp") || &cp | finish | endif

let g:loaded_whelp = 1

if !has_key(g:, 'whelp_file') || empty(g:whelp_file)
  let g:whelp_file = $HOME . "/.vim/whelp.txt"
endif

augroup Whelp
  au!
  au CmdlineLeave * call whelp#save()
  exec "au BufEnter" g:whelp_file "nnoremap <buffer> K :call whelp#reopen()\<CR>"
augroup END

command! -nargs=0 Helps :call whelp#show()
command! -nargs=0 -bang VHelps :call whelp#show('vsp', <bang>0)
command! -nargs=0 -bang SHelps :call whelp#show('sp', <bang>0)
command! -nargs=0 THelps :call whelp#show('tabe')
