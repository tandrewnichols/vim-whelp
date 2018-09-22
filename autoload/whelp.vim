function! whelp#save() abort
  " Don't entries if we run help from within the whelp list
  if getcmdtype() == ':' && &l:ft != 'whelp'
    let line = getcmdline()
    if line =~ '^h ' || line =~ '^help '
      let entry = join(split(line, ' ')[1:], ' ')
      if exists('*strftime')
        let now = strftime('%b %d, %Y at %I:%M:%S %p')
        let entry = entry . ' | ' . now
      endif
      let lines = readfile(g:whelp_file)
      call writefile([entry] + lines, g:whelp_file)
    endif
  endif
endfunction

function! whelp#reopen() abort
  let pos = getcurpos()
  normal ^"ay$
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
      exec "abo" type g:whelp_file
    else
      exec "bel" tpye g:whelp_file
    endif
  endif

  if type != 'e'
    call whelp#arm()
  endif

  call whelp#configure()
endfunction

function! whelp#arm() abort
  augroup AutocloseHelp
    au!
    exec "au BufLeave" g:whelp_file "q | au! AutocloseHelp BufLeave"
  augroup END
endfunction

function! whelp#disarm() abort
  au! AutocloseHelp BufLeave
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
