:command! Joeyhighlight call s:Joeyhighlight()

:function! s:Joeyhighlight()

	" Note: it seems (at least with DiffDelete), that setting cterm?g=... after
	" cterm=... can cause cterm= to be changed!

	" :colors pablo
	" :set guifont=-schumacher-clean-medium-r-normal-*-*-120-*-*-c-*-iso646.1991-irv
	" :set guifont=-schumacher-clean-medium-r-normal-*-*-150-*-*-c-*-iso646.1991-irv
	" :set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-100-*-*-m-*-iso8859-1

	" :set background=dark

	" :syntax on

	" :highlight Normal ctermbg=black ctermfg=grey guibg=Black guifg=#cccccc
	:highlight Normal ctermfg=grey guibg=Black guifg=#cccccc

	:highlight Title ctermbg=black ctermfg=green guibg=#000060 guifg=#00ff00

	:highlight WarningMsg ctermbg=black ctermfg=red cterm=bold

	" :highlight Normal ctermfg=LightGray guibg=#000000 guifg=LightGray

	:highlight DiffLine ctermbg=Magenta ctermfg=White
	" :highlight Search term=reverse,bold ctermbg=White guibg=White ctermfg=Black guifg=Black
	:highlight Search ctermbg=Blue ctermfg=White term=bold guibg=Blue guifg=White
	:highlight ErrorMsg ctermbg=Red ctermfg=Yellow guibg=Red guifg=Yellow
	:highlight Visual ctermfg=DarkMagenta ctermbg=White guifg=DarkMagenta guibg=White
	" :highlight Comment ctermfg=Magenta guifg=#80a080 " green-grey
	" :highlight Comment ctermfg=DarkMagenta guifg=LightMagenta
	" :highlight Comment ctermfg=DarkMagenta guifg=#d080d0
	" :highlight Comment ctermfg=Magenta guifg=#d080d0
	" :highlight Comment ctermfg=DarkCyan guifg=DarkCyan
	:highlight Comment term=none cterm=none ctermfg=DarkMagenta guifg=LightMagenta
	" :highlight Comment cterm=none ctermfg=DarkCyan guifg=LightMagenta
	" :highlight link jComment Comment
	:highlight jComment ctermfg=DarkYellow guifg=DarkYellow
	:highlight SpecialChar ctermfg=Red guifg=Red
	:highlight String ctermfg=DarkGreen guifg=#80f080 cterm=NONE
	:highlight Todo term=reverse cterm=reverse ctermbg=black ctermfg=red
	:highlight jNote term=reverse cterm=reverse ctermbg=black ctermfg=yellow

	" Code
	:highlight Boolean ctermfg=LightBlue guifg=LightBlue
	:highlight Constant ctermfg=DarkYellow guifg=DarkYellow

	" C
	:highlight cType ctermfg=Cyan guifg=Cyan
	:highlight PreProc ctermfg=Red guifg=Red

	" Java
	" It appears to ignore the contains, otherwise I could use start=/^/ =)
	" :syntax region javaClassLine start=/class / end=/{/ contains=javaClassDecl
	:highlight link javaClassLine javaClassDecl
	" :highlight javaClassDecl term=bold ctermbg=DarkGreen ctermfg=White cterm=bold guibg=DarkGreen guifg=White gui=bold
	:highlight javaClassDecl ctermbg=black ctermfg=green cterm=bold guibg=DarkGreen guifg=White gui=bold
	:highlight javaStorageClass term=NONE ctermfg=Cyan cterm=NONE guifg=Cyan gui=NONE
	:highlight javaType term=NONE cterm=NONE guifg=LightBlue gui=bold
	:highlight link javaOperator SpecialChar
	:highlight Type ctermfg=Red guifg=Red
	:highlight Number ctermfg=LightBlue guifg=LightBlue
	" To bring first sentence of Java comments in line with Comments.
	:highlight Special ctermfg=Magenta guifg=#d080d0

	" Shellscript
	" :highlight link shDeref shVariable
	:highlight shDeref term=underline cterm=none ctermfg=6 guifg=#30a0a0

	" For vimdiffs
	" :highlight DiffAdd ctermbg=Green cterm=bold guibg=DarkGreen
	" :highlight DiffDelete ctermbg=Blue guibg=DarkBlue
	" Black and Yellow
	" :highlight DiffAdd ctermbg=green ctermfg=white cterm=bold guibg=DarkGreen guifg=White gui=none
	" :highlight DiffText ctermbg=yellow ctermfg=white cterm=bold guibg=DarkYellow guifg=White gui=bold
	" :highlight DiffChange ctermfg=white ctermbg=black cterm=bold guifg=White guibg=#202020 gui=bold
	" :highlight DiffDelete ctermbg=black ctermfg=red cterm=none gui=bold guifg=#600000 guibg=black
	" :highlight DiffDelete ctermbg=blue ctermfg=blue cterm=none gui=bold guifg=#000060 guibg=#000060
	" :highlight DiffDelete ctermbg=black ctermfg=black cterm=none gui=bold guifg=Black guibg=Black
	" :highlight DiffAdd ctermbg=red ctermfg=white cterm=bold guibg=DarkRed guifg=White gui=bold
	" :highlight DiffText ctermbg=green ctermfg=white cterm=bold guibg=DarkGreen guifg=White gui=bold
	" Strongly mark lines with changes (white bg):
	" :highlight DiffChange ctermfg=black ctermbg=white cterm=bold gui=bold guifg=White guibg=Black
	" :highlight DiffDelete term=none ctermbg=black ctermfg=blue cterm=none guifg=#000050 guibg=#000050 gui=none
	:highlight DiffAdd ctermbg=green ctermfg=white cterm=bold guibg=DarkGreen guifg=White gui=bold
	:highlight DiffText ctermbg=red ctermfg=yellow cterm=bold guibg=red guifg=DarkRed gui=bold
	" Lines with changes only marked with brighter white fg, which doesn't always show:
	:highlight DiffChange ctermfg=white ctermbg=black cterm=bold gui=bold guifg=White guibg=Black
	:highlight DiffDelete term=none ctermbg=blue ctermfg=blue cterm=none guifg=DarkBlue guibg=DarkBlue gui=none

	" For jfc diffs
	" :syntax keyword difference jDiff @@>>
	:highlight jDiff ctermbg=Magenta ctermfg=White

	" For Mason sources
	" :highlight jComment ctermfg=Yellow guifg=#ffff00

	" Can't be bothered to put in proper place:

	" Haskell:
	:highlight hsStructure ctermfg=DarkYellow
	:highlight hsOperator ctermfg=DarkCyan

	" Prolog
	:highlight prologClauseHead ctermfg=DarkCyan

	":so /home/joey/linux/.vim/joeyfolding.vim

	" Highlight search (doesn't work if called at top of this file!)
	:set hlsearch

:endfun

:Joeyhighlight
