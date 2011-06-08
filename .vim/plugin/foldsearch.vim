" Fold up all blocks of text between your current search, leaving only hit
" lines unfolded (and some context lines).
"" BUG TODO: completely fails when the search appears on sequential lines
"" Because the k to move away from the next match actually moves up to the
"" previous line!
function! FoldSearch()
	set foldmethod=manual
	normal :0
	normal zE
	let l:contextk=''
	let l:contextj=''
	" let l:contextk='kk'
	" let l:contextj='jjjj'   " need as many as k, then own :P
	"" Recording: Find non-empty line.  Start visual.  Find double-line-break.  Create fold.
	" normal qf/^.v/\n\n\nzfq
	let @f="vnk".l:contextk."zfjj".l:contextj
	"" Execute as many times as possible, without wrapping to top of file
	set nowrapscan
	normal 999@f
	"" Will stop when no further match can be found - so complete the fold up to the last line
	normal 9999
	normal zf
	" Restore to "default":
	set wrapscan
endfunction
:command! FoldSearch call FoldSearch()

