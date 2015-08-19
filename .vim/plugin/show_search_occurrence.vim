" When performing a search, displays "(n/m)" in the statusbar to indicate the
" index of the current line within the list of matching lines in the buffer.
"
" To use this you need to add the function to your status line, for example:
"
"   :let &statusline = '%{GetSearchStatus()}' . &statusline
"
" (Note that the total count of matching lines is not the same as the number
" of occurrences, because one line could contain more than one match!)
"
" Inspired by http://stackoverflow.com/questions/23975604/
" See also: http://www.vim.org/scripts/script.php?script_id=1682#IndexedSearch
"           https://github.com/henrik/vim-indexed-search
" See also: http://www.vim.org/scripts/script.php?script_id=2634#SearchPosition

" If the current file is larger than the threshold (in bytes), then do not
" display the summary.  This can prevent sluggishness when working on large
" files.
let g:ShowSearchOccurrences_MaxBufferSize = get(g:, 'ShowSearchOccurrences_MaxBufferSize', 1000000)

let g:ShowSearchOccurrences_InCmdLine = get(g:, 'ShowSearchOccurrences_InCmdLine', 1)

" Optional argument 'long'
function! GetSearchStatus(...)
	let long = a:0 > 0 && a:1
	" Only display when in normal or visual mode
	if match(mode(),'[nv]') == -1
		return ""
	endif
	" Do nothing if there is no current search term
	if @/ == ""
		return ""
	endif
	" Only display when the cursor is sitting on the first character of a match
	let this_line = getline('.')
	let current_column = col('.')
	" Check if we are on one of the search results
	" TODO BUG: This only works if we are on the first character.  So it is not much use for e.g. /search/e-3
	if match(this_line, @/, current_column-1) == current_column-1
		let buffer_size = line2byte(line("$")+1)-1
		if buffer_size > g:ShowSearchOccurrences_MaxBufferSize
			return ""
		endif
		" Loop all the lines in the file, to calculate the number of matches
		let this_lnum = line('.')
		let count_matches = 0
		let this_index = -1
		let line_count = line("$")
		let lnum = 1
		while lnum <= line_count
			let line = getline(lnum)
			if match(line, @/) >= 0
				let count_matches += 1
				" If this match is on the current line, then record the index
				if lnum == this_lnum
					let this_index = count_matches
				end
			endif
			let lnum += 1
		endwhile
		if long
			return "On matching line " . this_index . " of " . count_matches
			"return "On match " . this_index . " of " . count_matches
		else
			return "(".this_index."/".count_matches.") "
		endif
	else
		return ""
	endif
endfunction

" Alternatively, instead of using the status line, we can display in the command line
function! s:ShowSearchStatus()
	if !g:ShowSearchOccurrences_InCmdLine
		return
	endif
	let status = GetSearchStatus(1)
	if status != ""
		echo status
	else
		" Clear the command line in case we were displaying something that is no longer valid
		echo
	endif
endfunction

" We can trigger it whenever the cursor has moved
augroup ShowSearchOccurrence
	autocmd!
	"autocmd CursorHold * call s:ShowSearchStatus()
	autocmd CursorMoved * call s:ShowSearchStatus()
augroup END

" Or we can trigger it only when we perform searches
"nnoremap <silent> n n:call <SID>ShowSearchStatus()<CR>
"nnoremap <silent> N N:call <SID>ShowSearchStatus()<CR>
"nnoremap <silent> * *:call <SID>ShowSearchStatus()<CR>
"nnoremap <silent> # #:call <SID>ShowSearchStatus()<CR>
