let s:whelpTimeFormat = '%b %d, %Y at %I:%M:%S %p'

function! whelp#save() abort
  " Don't entries if we run help from within the whelp list
  if getcmdtype() == ':' && &l:ft != 'whelp'
    let line = getcmdline()
    if line =~ '^h ' || line =~ '^help '
      let entry = join(split(line, ' ')[1:], ' ')
      if exists('*strftime')
        let now = strftime(s:whelpTimeFormat)
        let entry = entry . ' | ' . now
      endif
      let lines = readfile(g:whelp_file)
      call writefile([entry] + lines, g:whelp_file)
    endif
  endif
endfunction

function! whelp#reopen() abort
  let pos = getcurpos()
  normal! ^"ay$
  let text = split(@a, ' | ')[0]
  call setpos('.', pos)

  call whelp#disarm()
  exec "h" text
  call whelp#arm()
endfunction

function! whelp#show(...) abort
  let type = a:0 == 0 ? "e" : a:1
  let bang = a:0 == 2 ? a:2 : 0
  if !bang
    exec type g:whelp_file
  else
    if (type == 'vsp' && &splitbelow) || (type == 'sp' && &splitright)
      exec "abo keepjumps hide" type g:whelp_file
    else
      exec "bel keepjumps hide" type g:whelp_file
    endif
  endif

  if type != 'e'
    call whelp#arm()
  endif

  call whelp#configure()
endfunction

function! whelp#arm() abort
  if g:whelp_autoclose
    augroup AutocloseHelp
      au!
      exec "au BufLeave" g:whelp_file "bw | au! AutocloseHelp BufLeave"
    augroup END
  endif
endfunction

function! whelp#disarm() abort
  if exists('#AutocloseHelp#BufLeave')
    au! AutocloseHelp BufLeave
  endif
endfunction

function! whelp#configure() abort
  setlocal foldcolumn=0
  setlocal nofoldenable
  setlocal nospell
  setlocal nobuflisted
  setlocal filetype=whelp
  setlocal nomodifiable
  setlocal noswapfile
  setlocal nowrap

  exec "nnoremap <silent> <nowait> <buffer>" g:whelp_remove_entry_mapping ":<C-U>call whelp#removeEntry()\<CR>"
  exec "nnoremap <silent> <nowait> <buffer>" g:whelp_reopen_entry_mapping ":call whelp#reopen()\<CR>"
endfunction

function! whelp#removeEntry() abort
  setlocal modifiable
  if v:count > 0
    exec "normal!" v:count . "dd"
  else
    normal! dd
  endif
  w
  setlocal nomodifiable
endfunction

function! whelp#clear() abort
  call writefile([], g:whelp_file)
endfunction

function! whelp#dedupe() abort
  let lines = readfile(g:whelp_file)
  let kept = []
  let list = []
  for line in lines
    let entry = split(line, ' | ')[0]
    if index(kept, entry) == -1
      call add(list, line)
      call add(kept, entry)
    endif
  endfor

  call writefile(list, g:whelp_file)
endfunction

function! whelp#prune(count) abort
  " Count is number of days, so multiple by number of seconds in a day
  " and subtract that number from the current epoch to get a cutoff timestamp
  let time = localtime() - (count * 86400)
  let lines = readfile(g:whelp_file)
  if !len(lines)
    return
  endif

  for line in lines
    let entrytime = strftime(s:whelpTimeFormat, split(line, ' | ')[1])
    if entrytime < time
      let index = index(lines, line)
      break
    endif
  endfor

  if index == 0
    call writefile([], g:whelp_file)
  else
    call writefile(lines[0:index - 1], g:whelp_file)
  endif
endfunction
