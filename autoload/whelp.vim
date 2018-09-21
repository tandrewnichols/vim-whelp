function! whelp#save() abort
  if getcmdtype() == ':'
    let line = getcmdline()
    if line =~ '^h ' || line =~ '^help '
      let entry = join(split(line, ' ')[1:], ' ')
      if exists('*strftime')
        let now = strftime('%b %d, %Y at %I:%M:%S %p')
        let entry = entry . ' | ' . now
      endif
      call writefile([entry], g:whelp_file, "a")
    endif
  endif
endfunction

function! whelp#reopen() abort
  let pos = getcurpos()
  normal ^"ay$
  if @a =~ ' | '
    let @a = split(@a, ' | ')[0]
  endif
  call setpos('.', pos)
  exec "noautocmd h" @a

  " noautocmd makes syntax highlighting break in help files
  " so just set the filetype manually to retrigger highlighting
  setf help
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

  call whelp#configure()
endfunction

function! whelp#configure() abort
  setlocal foldcolumn=0
  setlocal nofoldenable
  setlocal nospell
  setlocal nobuflisted
  setlocal filetype=whelp
  setlocal buftype=nofile
  setlocal nomodifiable
  setlocal noswapfile
  setlocal nowrap
endfunction
