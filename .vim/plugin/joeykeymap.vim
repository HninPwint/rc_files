
"" F5 and F6 comment and uncomment the current line.
" echo &filetype
if "&filetype" == "xml" || "&filetype" == "xslt"
	map <F5> ^i<!--  --><Esc>j^
	map <F6> ^5x$xxxx^
else
	map <F5> ^i// <Esc>j^
	map <F6> ^3xj^
:endif

"" F7 and F8 indent or unindent the current line.
"" (Expects/requires ts=2 sw=2 and noexpandtabs!)
map <F7> ^i  <Esc>j^
map <F8> 0xj^

"" Shortcut for re-joining lines broken by \n.
"" BUG: Deletes next char if current line is empty!
" map <F7> Js<Return><Esc> 

" C "changes word under cursor" (replaces "change to end of line", c$)
nmap C \ bcw

nmap <C-X>x :vnew \| vimshell bash<CR>

"" Various failed shortcuts for the 'follow link' command.
" map <C-Enter> <C-]>
" map <C-.> <C-]>
" map <C-#> <C-]>
" map <C-'> <C-]>
" map <C-@> <C-]>
" map <C-;> <C-]>
" map <C-Minus> <C-]>
" map <C-Equals> <C-]>
" map <C-p> <C-]>
" map <C-O> <C-]>
" map <C-p> <C-LeftMouse>
" map <C-p> g<LeftMouse>
" map <C-p> :tag

"" Quick switching between files:
" map <C-Right> :n<Enter>
" map <C-Left> :N<Enter>
" map <C-PageDown> :n<Enter>
" map <C-PageUp> :N<Enter>

"" These two work best with MiniBufExplorer
noremap <C-PageDown> :bnext<Enter>
noremap <C-PageUp> :bprev<Enter>
inoremap <C-PageDown> <Esc>:bnext<Enter>
inoremap <C-PageUp> <Esc>:bprev<Enter>
"" (not working?)
" inoremap <C-PageUp> <Esc><C-PageUp>a
" inoremap <C-PageDown> <Esc><C-PageDown>a

" map <F8> :tabprev<Enter>
" map <F9> :tabnext<Enter>
" map <C-[> :tabprev<Enter>
" map <C-]> :tabnext<Enter>
" map <C-[> :N<Enter>
" map <C-]> :n<Enter>

"" I'm sure there must be a better way to do this.
"" I'm trying to make a new command, but really just catching the keys!
map :htab :tabnew<Enter>:h

" :noremap <C-Down>  10<C-w>-<C-W>j10<C-w>+
" :noremap <C-Up>    10<C-w>-<C-W>k10<C-w>+
" :noremap <C-Left>  10<C-w><<C-W>h10<C-w>>
" :noremap <C-Right> 10<C-w><<C-W>l10<C-w>>

"" Moving between windows
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l

"" I want them to work in insert mode also (especially with ConqueTerm)
inoremap <C-Up> <Esc><C-w>ka
inoremap <C-Down> <Esc><C-w>ja
inoremap <C-Left> <Esc><C-w>ha
inoremap <C-Right> <Esc><C-w>la

"" Close the current window on Ctrl-W (like browser tabs).
"" This overrides a lot of C-w defaults.  Really I want to wait and see if
"" the use presses anything else.  It is pretty dangerous at the moment!
" nnoremap <C-w> :bdel<Enter>

"" Here is too early, our value gets dropped.
" :set winheight 40

"" Allow navigation on wrapped lines with arrows
nnoremap <Up> gk
nnoremap <Down> gj

"" For GVim
inoremap <S-Insert> <Esc>"*pa

"" These work for Eterm, provided we export TERM=xterm before we run vim:
nnoremap [6^ :bn<Enter>
nnoremap [5^ :bp<Enter>

"" Although these allow Ctrl-W Up/Down/Left/Right in Eterm, they break normal
"" Up/Down/Left/Right in xterm.
" nnoremap OA k
" nnoremap OB j
" nnoremap OD h
" nnoremap OC l

" nnoremap Oa k
" nnoremap Ob j
" nnoremap Od h
" nnoremap Oc l

"" Quick access to ConqueTerm
:nnoremap <C-x> :ConqueTermSplit zsh<Enter>
:inoremap <C-x> <Esc>:echo "Hello"<Enter>
" :inoremap <C-x> <Esc>:bdel<Enter>
"" And my ConqueTerm settings:
let g:ConqueTerm_ReadUnfocused = 1

"" I want :q to close the buffer, not the window.
"" Unfortunately this does not quit Vim if we are on the last buffer.
" nmap :q<Enter> :bdel<Enter>
" nmap :wq<Enter> :w<Enter>:bdel<Enter>
"" Meh turns out I don't always want to close the buffer.  I often use :q just
"" to close an extra window I no longer want.

"" Step through cope list (errors/search results) with Ctrl+N/P
:nnoremap <C-n> :cnext<Enter>
:nnoremap <C-p> :cprev<Enter>
"" =/- get overriden by fold keymaps :P
" :nnoremap = :cnext<Enter>
" :nnoremap - :cprev<Enter>
"" +/_ (Shift equivalent) also get overridden
" :nnoremap + :cnext<Enter>
" :nnoremap _ :cprev<Enter>

" Joey's little trick - really lives elsewhere.
" :e usually clears undo history, so we don't really do :e any more.
" We delete the contents of the buffer, then read the file in, which
" is an operation we can undo.  We must delete the top (empty) line also.
" :map :e<Enter> :%d<Enter>:r<Enter>:0<Enter>dd
" BUG: vim still thinks the file is out of sync with the buffer, so if you
" quit without writing the file, vim complains, which is not how :e behaved.
:map :e<Enter> :%d<Enter>:r<Enter>:0<Enter>dd:w!<Enter>
" Unfortunately the ! in :w! doesn't work
" Also it seems to me that this is firing when I do ":e!"

" Scroll the page up and down with Ctrl+K/J
" Only moves the cursor when it's near the edge
noremap <C-K> 1<C-Y>
noremap <C-J> 1<C-E>
inoremap <C-K> <Esc>1<C-Y>a
inoremap <C-J> <Esc>1<C-E>a

