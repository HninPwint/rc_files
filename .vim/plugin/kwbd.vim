" Closing the buffer with :bdelete sucks because it closes the window too!
" We want to close the buffer but have the window switch to the most-recent or
" "previous" buffer.  This is what :Kwbd does, but I call it :CloseBuffer.

"Keep Windows bdel - from http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
"here is a more exotic version of my original Kwbd script
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function! s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=nofile
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call <SID>Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>

" Create a mapping (e.g. in your .vimrc) like this:
"nmap <C-W>! <Plug>Kwbd

"" A name I found more memorable:
" command! Bdel call <SID>Kwbd(1)
"" Catch me trying to do a normal bdel, and switch to friendlier command:
" nnoremap :bdel :Bdel
"" Try to remind me what I am really calling:
" nnoremap :bdel :Kwbd
"" Encourage me to acknowledge I am doing something different:
" command! Bclose call <SID>Kwbd(1)
" nnoremap :bdel :Bclose
" command! CloseBuffer call <SID>Kwbd(1)
command! CloseBuffer :Kwbd
nnoremap :bdel :CloseBuffer

