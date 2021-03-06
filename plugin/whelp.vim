if exists("g:loaded_whelp") || &cp | finish | endif

let g:loaded_whelp = 1

let g:whelp_VERSION = '1.0.1'
let g:whelp_autoclose = get(g:, 'whelp_autoclose', 1)
let g:whelp_remove_entry_mapping = get(g:, 'whelp_remove_entry_mapping', '-')
let g:whelp_reopen_entry_mapping = get(g:, 'whelp_reopen_entry_mapping', 'K')

if !has_key(g:, 'whelp_file') || empty(g:whelp_file)
  let g:whelp_file = $HOME . "/.vim/whelp.txt"
endif

augroup Whelp
  au!
  au CmdlineLeave * call whelp#save()
augroup END

command! -nargs=0 Whelp :call whelp#show()
command! -nargs=0 -bang VWhelp :call whelp#show('vsp', <bang>0)
command! -nargs=0 -bang SWhelp :call whelp#show('sp', <bang>0)
command! -nargs=0 TWhelp :call whelp#show('tabe')
command! -nargs=0 ClearWhelp :call whelp#clear()
command! -nargs=0 DedupeWhelp :call whelp#dedupe()
command! -nargs=1 PruneWhelp :call whelp#prune(<args>)
