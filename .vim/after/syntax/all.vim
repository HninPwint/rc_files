"" This is nonsense:
" :let g:vimsynloaded=1
" if ! g:vimsynloaded == 1
	" source ~/.vim/after/syntax/all.vim
" endif

" comment
:map <F5> ^i" <Esc>j^
" uncomment
:map <F6> ^2xj^
" indent
:map <F7> ^i  <Esc>j^
" undent
:map <F8> 02xj^
