"" Highlights the character under the cursor so that it appears reversed.
"" Very useful if for some reason your normal cursor has disappeared or is
"" missing, invisible, hidden or intermittent.

"" Hit Ctrl-C or Ctrl-H to toggle on/off.

"" BUGS: If your cursor really has disappeared, this highlighting method will
""       not help you to edit commands in ex mode.

"" TODO: Choose cursor colour to constrast :set background or :highlight Normal.
""       I don't know how to read the output of the :set or :highlight commands.

"" Also handy: keeps cursor in center of screen
"" set scrolloff=999

function! HighlightCursorRefresh()
	if exists("g:highlightcursor")
		call HighlightCursorOff()
		call HighlightCursorOn()
	endif
endfunction

function! HighlightCursorOff()
	match None
endfunction

function! HighlightCursorOn()
	"" Intended to cycle colours constantly, but events only fired on keypress.
	"" So I tried a while loop with sleep but no user interaction got through.
	"" Fix: We could use getchar(0) and if it exists, send it to the keyboard!
	""      I reckon that will only animate in Command mode, not Insert mode.
	" " while 1
	" let g:highlightcursor=g:highlightcursor+1
	" if g:highlightcursor > 7
		" let g:highlightcursor=1
	" endif
	" exe 'highlight CursorHighlighted ctermfg=black ctermbg=' . g:highlightcursor
	" " sleep 200m
	" " endwhile
	match ToDo /.*\%#.*/
	match CursorHighlighted /\%#/
endfunction

function! HighlightCursorToggle()
	if exists("g:highlightcursor")
		unlet g:highlightcursor
		"" Clear autocmds etc.
		call HighlightCursorOff()
		" TODO: should restore to whatever it was before
		set updatetime=20
	else
		let g:highlightcursor=1
		set updatetime=10
		autocmd CursorHold * :call HighlightCursorRefresh()
		" autocmd BufEnter * :call HighlightCursorRefresh()
		highlight CursorHighlighted term=reverse ctermfg=black ctermbg=green guifg=black guibg=#00ff00
		call HighlightCursorRefresh()
	endif
endfunction

map <C-C> :call HighlightCursorToggle()<CR>
"" To make way for JrandomHighlight in joeycommands.vim:
" map <C-H> :call HighlightCursorToggle()<CR>

"" Uncomment this line to have the cursor highlighted as default:
" :call HighlightCursorToggle()
