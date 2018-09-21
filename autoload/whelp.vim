function! whelp#save() abort
  if getcmdtype() == ':'
    let line = getcmdline()
    if line =~ '^h ' || line =~ '^help '
      let entry = join(split(line, ' ')[1:], ' ')
      call writefile([entry], g:whelp_file, "a")
    endif
  endif
endfunction

function! whelp#reopen() abort
  let pos = getcurpos()
  normal ^"ay$
  call setpos('.', pos)
  exec "noautocmd h" @a
endfunction

function! whelp#show(...) abort
  let type = a:0 == 0 ? "e" : a:1
  let bang = a:0 == 2 ? a:2 : 0
  if !bang
    exec type g:whelp_file
  else
    if (type == 'vsp' && &splitbelow) || (type == 'sp' && &splitright)
      exec "abo" type g:whelp_file
    else
      exec "bel" tpye g:whelp_file
    endif
  endif

  if type != 'e'
    augroup AutocloseHelp
      au!
      exec "au BufLeave" g:whelp_file "q | au! AutocloseHelp BufLeave"
    augroup END
  endif
endfunction
