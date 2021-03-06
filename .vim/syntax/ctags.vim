" Some syntax rules to make ctags files more readable

" CONSIDER: ctags is not the only filetype where regexps can be used
"           We might want to propagate these additional syntax rules (and custom colours) to regexps in other filetypes too.

" TODO: I used hs= and he= but perhaps I should have used ms= and me= instead.
"       That might avoid having to specify contains just because we matched
"       outside the desired target.

syntax match Statement /^--[^=]*=/hs=e,he=e contains=ctagsOption,Regexp
syntax match ctagsOption /^--[^=]*=/he=e-1 contained
syntax match Regexp /\/.*\/.,/hs=s+0,he=e-2 contains=RegexpCore,RegexpReplacement
syntax match Regexp /\/$/
syntax match RegexpCore /\/.*\ze\/[^/]*\/.,/hs=s+1 contained contains=Comment,RegexpSpecialChar,RegexpWhitespaceChar,RegexpOptWhitespaceChar,RegexpSpecial,RegexpSeparator
syntax match RegexpReplacement /\/[^/]*\/.,/hs=s+1,he=e-3 contained
syntax match RegexpSpecialChar /\\./ contained
syntax match RegexpSpecial /[+*[\]]/ contained
syntax match RegexpWhitespaceChar /\(\\s\|\\t\|\[\\t \]\|\[ \\t\]\)\(+\|\)/ contained
syntax match RegexpOptWhitespaceChar /\(\\s\|\\t\|\[\\t \]\|\[ \\t\]\)\*/ contained
syntax match RegexpSpecial /\(\\<\|\\>\)/ contained
syntax match RegexpSeparator /[()]/ contained

syntax match Comment /\^(\(COMMENT\|BUG\|TODO\|NOTE\|DONE\|FIXME\): .*)\//hs=s+2,he=e-2 contained contains=RegexpReplacement
syntax match Comment /\^DISABLED: .*\/\\1/hs=s+1,he=e-3 contained contains=RegexpReplacement

hi link ctagsOption Normal
hi link Regexp Special
hi link RegexpCore String
hi link RegexpReplacement Identifier
hi link RegexpWhitespaceChar SpecialKey
hi link RegexpOptWhitespaceChar SpecialKey
hi link RegexpSpecialChar SpecialChar
hi link RegexpSpecial Special
hi link RegexpSeparator RegexpReplacement
