"" Quick switching between files:
" map <C-Right> :n<Enter>
" map <C-Left> :N<Enter>
" map <C-PageDown> :n<Enter>
" map <C-PageUp> :N<Enter>

"" These two work best with MiniBufExplorer
nnoremap <C-PageDown> :bnext<Enter>
nnoremap <C-PageUp> :bprev<Enter>
inoremap <C-PageDown> <Esc>:bnext<Enter>i
inoremap <C-PageUp> <Esc>:bprev<Enter>i
"" (not working?)
" inoremap <C-PageUp> <Esc><C-PageUp>a
" inoremap <C-PageDown> <Esc><C-PageDown>a

"" Sometimes I want to re-arrange the order of the buffers in my list.  After
"" years of nothing, I now at least found a way to push buffers to the end, by
"" completely removing them first with bwipeout.
"" Loses all undo history.
" TODO: Might belong in its own plugin file.
nnoremap <silent> <C-S-PageDown> :call <SID>MoveCurrentBufferToEndOfList()<Enter>
nnoremap <silent> <C-A-PageDown> :call <SID>MoveCurrentBufferToEndOfList()<Enter>
function s:MoveCurrentBufferToEndOfList()
	let fname = expand("%")
	" This bwipeout may not succeed if the file has unwritten changes.
	bwipeout
	" TODO: Do we need to escape spaces in filenames with spaces?
	exec "edit ".fname
endfunction
" Since C-S-PageDown never makes it through my xterm, we expose a user command too:
command! MoveBufferToEnd call s:MoveCurrentBufferToEndOfList()
" Oh!  C-A-PageDown does make it through.  :)

"" These versions work for my Eterm, provided we exported TERM=xterm
nnoremap [6^ :bn<Enter>
nnoremap [5^ :bp<Enter>
"" In hwi and pod's console (TERM=linux), PageUp/Down send the same with/without Ctrl.
" nnoremap [6~ :bn<Enter>
" nnoremap [5~ :bp<Enter>

"" Inside screen on pea:
noremap [6;5~ :bn<Enter>
noremap [5;5~ :bp<Enter>



" map <F8> :tabprev<Enter>
" map <F9> :tabnext<Enter>
" map <C-[> :tabprev<Enter>
" map <C-]> :tabnext<Enter>
" map <C-[> :N<Enter>
" map <C-]> :n<Enter>

"" I'm sure there must be a better way to do this.
"" I'm trying to make a new command, but really just catching the keys!
map :htab :tabnew<Enter>:h



"" Moving between windows with Ctrl-ArrowKeys
nmap <C-Up> <C-W>k
nmap <C-Down> <C-W>j
nmap <C-Left> <C-W>h
nmap <C-Right> <C-W>l

"" I want them to work in insert mode also (especially with ConqueTerm)
"imap <C-Up> <Esc><C-W>ka
"imap <C-Down> <Esc><C-W>ja
"imap <C-Left> <Esc><C-W>ha
"imap <C-Right> <Esc><C-W>la
"" Except in ConqueTerm I don't neccessarily want to return to Insert mode,
"" if I was not in Insert mode before I entered ConqueTerm.
" TODO: This may be interfering with navigation_enhancer and/or Conque's
" restore-previous-insert-or-normal-mode.
" (When I go up from ConqueTerm in insert mode, I get left in TreeExplorer,
" not editor, or vice-versa, i.e. navigation_enhancer was being ignored.),
" possibly because one of :startinsert or 'a' fails because both conque and
" this bind do that!  Instead consider calling a function to perform the above
" without erroring.
" Just disabled them for now.  I don't think I actually use them!

"" For Eterm.  Caused no problems for xterm the last time I tried it.
nmap Oa <C-W>k
nmap Ob <C-W>j
nmap Od <C-W>h
nmap Oc <C-W>l

"" For Linux console:
nmap [A <C-W>k
nmap [B <C-W>j
nmap [D <C-W>h
nmap [C <C-W>l

"" Inside screen on pea:
nmap [1;5A <C-W>k
nmap [1;5B <C-W>j
nmap [1;5D <C-W>h
nmap [1;5C <C-W>l

"" I was using these to allow Ctrl-Up/Down/Left/Right in Eterm, but they broke
"" normal Up/Down/Left/Right in xterm!
" nmap OA k
" nmap OB j
" nmap OD h
" nmap OC l

" We allow remapping on the above so navigation_enhancer can intecept them.



"" Step through quickfix list (errors/search results) with Ctrl+N/P
:nnoremap <C-n> :cnext<Enter>
:nnoremap <C-p> :cprev<Enter>
"" =/- get overriden by fold keymaps :P
" :nnoremap = :cnext<Enter>
" :nnoremap - :cprev<Enter>
"" +/_ (Shift equivalent) also get overridden
" :nnoremap + :cnext<Enter>
" :nnoremap _ :cprev<Enter>

"" Navigate wrapped lines in screen space using arrows
nnoremap <Up> gk
nnoremap <Down> gj

" Scroll the page up and down with Ctrl+K/J
" Only moves the cursor when it's near the edge
"" We can prepend a number to the scroll request if desired, e.g. 5<C-K>
noremap <C-K> <C-Y>
noremap <C-J> <C-E>
inoremap <C-K> <Esc><C-Y>a
inoremap <C-J> <Esc><C-E>a
"" Since the first two do not always trigger a CursorHold or Moved event, they fail
"" to trigger the highlight_line_after_jump script.  The following attempt to
"" force it fails because on occasions where the event is triggered, the
"" highlight script sees it twice, and unhighlights the line!
" noremap <C-K> <C-Y>:silent! call HL_Cursor_Moved()<Enter>
" noremap <C-J> <C-E>:silent! call HL_Cursor_Moved()<Enter>

"" Split windows vertically with Ctrl-W Shift-S
"" The default is c-W v
"nnoremap <C-W>s :split<Enter>
nnoremap <C-W>S :vsplit<Enter>

" Resize windows with Ctrl-NumPadPlus/Minus/Divide/Times:
"" We defer to the implementation in windows_remember_size.vim
"" This was happening automatically before - perhaps their run order changed?
"nnoremap Om :resize -2<Enter>
"nnoremap Ok :resize +2<Enter>
"nnoremap Oo :vert resize -6<Enter>
"nnoremap Oj :vert resize +6<Enter>



" Joey's little trick - maybe belongs elsewhere.
" :e usually clears undo history, so we don't really do :e any more.
" We delete the contents of the buffer, then read the file in, which
" is an operation we can undo.  We must delete the top (empty) line also.
" :map :e<Enter> :%d<Enter>:r<Enter>:0<Enter>dd
" BUG: vim still thinks the file is out of sync with the buffer, so if you
" quit without writing the file, vim complains, which is not how :e behaved.
:map :e<Enter> :%d<Enter>:r<Enter>:0<Enter>dd:w!<Enter>
" Unfortunately the ! in :w! doesn't work

"" Close the current window on Ctrl-W (like browser tabs).
"" This overrides a lot of C-w defaults.  Really I want to wait and see if
"" the use presses anything else.  It is pretty dangerous at the moment!
" nnoremap <C-w> :bdel<Enter>

"" For GVim
inoremap <S-Insert> <Esc>"*pa

" nmap <C-X> :vnew \| vimshell bash<CR>

"" Quick access to ConqueTerm
:nnoremap <C-x> :ConqueTermSplit zsh<Enter>
:inoremap <C-x> <Esc>:echo "Hello"<Enter>
" :inoremap <C-x> <Esc>:bdel<Enter>
"" My ConqueTerm settings live in ~/.vimrc

"" I want :q to close the buffer, not the window.
"" Unfortunately this does not quit Vim if we are on the last buffer.
" nmap :q<Enter> :bdel<Enter>
" nmap :wq<Enter> :w<Enter>:bdel<Enter>
"" Meh turns out I don't always want to close the buffer.  I often use :q just
"" to close an extra window I no longer want.



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



"" Command-line keymaps.
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
"" In keeping with my shell shortcut keys
"" Word jump
cnoremap <C-D> <C-Left>
cnoremap <C-F> <C-Right>
"" Small-word jump.  But Vim doesn't offer one!
"" In cmdline, S-Left/Right is the same as C-Left/Right
"" So here is a near approximation:
cnoremap <C-R> <Left><Left><Left>
cnoremap <C-T> <Right><Right><Right>
"" Word swallow Ctrl-X Ctrl-V
cnoremap <C-X> <C-W>
"" This doesn't do what we want, also we want to leave Ctrl-V since it does
"" something special in Vim (insert literal char).
" cnoremap <C-V> <C-Right><C-W>
"" Lazy move.  Ctrl-Space just walks over the current char.
"" I must say C-@ instead of C-Space!
cnoremap <C-@> <Right>
" Same for normal mode:
inoremap <C-@> <Right>
"" Can't map C-Backspace; BS emits C-H with or without Ctrl.
" cnoremap <C-BS> <Left>

"" Now the same for Insert-mode?  Well a select few perhaps...
inoremap <C-X> <Esc>dbxi
"" Except we won't do <C-V> because that has a useful meaning already
inoremap <C-D> <Esc>bi
"" And <C-F> already means toggle fullscreen.
"inoremap <C-F> <Esc>ea
inoremap <C-F> <Esc>wi
"inoremap <C-A> <Home>
"inoremap <C-E> <End>
"" By default <C-A> performs the last . which could be pretty handy.
"" Default <C-E> copies 1 char from the cell above (useful in the 80s).

"" Because we overwrote Ctrl-D, we need a new one:
cnoremap <C-L> <C-D>

" This is how my zsh does completion, and it rocks (unless for some reason you
" always want the first match of multiples, then you must always Tab twice).
set wildmode=longest:full,full
" I use the default wildchar=<Tab>


" Make a global mark 'Q' with 'mQ' and jump back to it with 'MQ'.
nmap M g'
" M usually does to-middle-line-of-window


" Quick toggles for most frequently used functions
nnoremap <Leader>t :Tlist<Enter>
nnoremap <Leader>w :set invwrap<Enter>

" Quick buffer switching (beyond Ctrl-PageUp/Down)
"" Select buffer by any part of filename and Tab completion or arrows, or by number
nnoremap <C-E> :ls<CR>:b<space>
"" Select file by filename with completion
" nnoremap <C-E> :ls<CR>:e<space>
"" Select by name with completion or file without (joeys_buffer_switcher.vim)
nnoremap <Leader>e :JoeysBufferSwitch<Enter>
"" Select buffer from list (bufexplorer.vim)
nnoremap <C-B> :BufExplorer<Enter>
"" Select from persistent list of most-recently-used files (mru.vim)
nnoremap <Leader>b :MRU<Enter>
"" Some more alternative buffer switchers:
"" :EasyBuffer (easybuffer.vim)

" NetRW file explorer (bundled)
nnoremap <Leader>o :Explore .<Enter>
" NERDTree file explorer (NERD_tree.vim)
nnoremap <Leader>f :e .<Enter>
nnoremap <Leader>F :VSTreeExploreToggle<Enter>

nnoremap <Leader>S :SessionList<Enter>



"" Close Current Buffer
"" Ctrl-Q is the unlock terminal code, and the terminal swallows it (does not pass it to vim).
" nnoremap <C-Q> :CloseBuffer<Enter>
"" Ctrl-Z works ok
nnoremap <C-Z> :CloseBuffer<Enter>
"" CloseBuffer is implemented in (kwbd.vim)

