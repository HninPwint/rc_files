:command! Joeysyntax call Joeysyntax()
if has("menu")
	amenu &Joey's\ Tools.&Joey's\ syntax\ rulez :call Joeysyntax()<CR>
endif

:function! Joeysyntax()

	" For slow computers:
	" :syn sync maxlines=50
	" :syn sync minlines=10

	" :colors pablo
	" :set guifont=-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso646.1991-irv
	" :set guifont=-schumacher-clean-medium-r-normal-*-*-150-*-*-c-*-iso646.1991-irv
	" :set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-100-*-*-m-*-iso8859-1
	" :set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-100-*-*-m-*-iso8859-1
	" :set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-80-*-*-m-*-iso8859-1
	" :set guifont=-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso646.1991-irv
	" :set guifont=-b&h-lucidatypewriter-medium-r-normal-*-14-*-*-*-m-*-iso10646-1
	:set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-80-*-*-m-*-iso10646-1
	:set background=dark

	:syntax on

	"" Doesn't work for C - overidden by bracket matches?
	:syntax match functionCall /[[:alpha:][:digit:]]+(/
	:highlight functionCall ctermfg=cyan

	" :syntax region javaClassLine start=/class / end=/{/ contains=javaClassDecl

	" for jfc diffs
	:syntax keyword jDiff @@>>

	" for Mason
	:syntax region jComment start="/\*"  end="\*/"

	" for sh, but bad for #defines!
	" :syntax region jShComment start="[#]*## " end='$'
	" :highlight link jShComment jComment

	" :syntax match jEq /=/
	"" for webscraping log:
	:syntax match jEq /[[:alpha:]]*=/
	:highlight link jEq Statement

	" :syntax keyword jTodo TODO
	" :highlight link jTodo Todo
	" :syntax keyword jNote NOTE
	" :highlight link jNote Todo
	"" Marche pas:
	" :syntax keyword jTodo TODO Todo BUG BUGS Consider:
	"" Hmm the standard TODO's are contained inside Comment types
	" :syntax contain jTodo BUG linksto Todo
	"" BUG: Doesn't always work.  Works better now.  Wish I could say containedin=*
	" :highlight! link jTodo Todo
	:syntax keyword jTodo TODO Todo ToDo todo BUG BUGS containedin=Comment,jShComment,jComment
	:highlight jTodo ctermbg=red ctermfg=black guibg=red guifg=black
	:syntax keyword jNote NOTE Note \<NB: Consider: CONSIDER containedin=Comment,jShComment,jComment
	:highlight jNote ctermbg=yellow ctermfg=black guibg=yellow guifg=black

	:syntax match jXmlBits /\(<\|>\)[[:alpha:]]*/
	:highlight jXmlBits ctermfg=red term=bold

	"" Log4j:
	" :syntax match log4jDebug " DEBUG "
	" :syntax match log4jInfo  " INFO "
	" :syntax match log4jWarn  " WARN "
	" :syntax match log4jError " ERROR "
	:syntax match log4jDebug "^.* DEBUG .*$"
	:syntax match log4jInfo  "^.* INFO .*$"
	:syntax match log4jWarn  "^.* WARN .*$"
	:syntax match log4jError "^.* ERROR .*$"

:endfun

" :Joeysyntax
