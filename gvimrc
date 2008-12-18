set mousehide
set nowrap
set backupdir=C:\\Progra~1\\Vim\\backups
set directory=C:\\Progra~1\\Vim\\backups
set guifont=Consolas:h9:cANSI
hi linenr guifg=LightSlateGray guibg=gray97
hi matchparen guibg=gray94 guifg=Black
set guicursor=a:ver25-blinkwait1000-blinkoff1000-blinkon1000
set history=100
set number
set nuw=3
set guioptions-=T
set guioptions-=m
set showtabline=2
set guitablabel=%m%t
set ts=4
set ai
set sw=4
set smartindent
set tabpagemax=100
set browsedir=buffer
set autoread

map <A-l> :tabn
map <A-h> :tabp

set comments=s1:/*,mb:*,ex:*/
set formatoptions=qrowcb
set keywordprg=bash\ /bin/lookup_php_func

nmap Y y$
map [[ :sil exe search("{", 'b')<CR>
map ][ /}<CR>b99]}
map ]] :sil exe search("{")<CR>
map [] k$][%?}<CR>

map } :sil exe search("^\\s*$")<CR>
map { :sil exe search("^\\s*$", 'b')<CR>

" if editing wikimedia stuff
fun! WikiOn()
	vmap h1 `<i==`>a==
	vmap h2 `<i===`>a===
	vmap hi `<i''`>a''
	vmap hb `<i'''`>a'''
	vmap hc `<O<code><pre>`>o</pre></code>
endfun

fun! WikiOff()
	vunmap h1
	vunmap h2
	vunmap hc
	vunmap hi
	vunmap hb
endfun

vmap <silent> * "yy:let @/='\(' . substitute(escape(@y, '$*^[]~\/.'), '\_s\+', '\\_s\\+', 'g') . '\)'<CR>//<CR> 
vmap <silent> # "yy:let @/='\(' . substitute(escape(@y, '$*^[]~\/.'), '\_s\+', '\\_s\\+', 'g') . '\)'<CR>??<CR>

fun! FindBlankLine(flags) range
	if (a:flags == 'b')
		normal gv?^\s*$
	else
		normal gv/^\s*$
	endif
endfun

vmap } :call FindBlankLine('')<CR>
vmap { :call FindBlankLine('b')<CR>

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
endif

" Set options and add mapping such that Vim behaves a lot like MS-Windows
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Apr 02

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
  finish
endif

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin
set selectmode=

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" set [m & ]m to work like our methods
noremap ]m j]mk
noremap [m [mk

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y
map <C-O>	:browse tabnew<CR>
map <C-L>	:O 
map <C-Space>	:O .<CR>
imap <C-L>	<Esc>:O 
imap <C-Space>	<Esc>:O .<CR>

" Open a new tab
map <C-N> :tabe<CR>
imap <C-N> <Esc>:tabe<CR>

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>:update<CR>
vnoremap <C-S>		<C-C>:update<CR><C-C>:update<CR>
inoremap <C-S>		<Esc>:update<CR>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" Alt-Space is System menu
if has("gui")
noremap <M-Space> :simalt ~<CR>
inoremap <M-Space> <C-O>:simalt ~<CR>
cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> ggVG
inoremap <C-A> <C-O>gg<C-O>V<C-O>G
cnoremap <C-A> <C-C>ggV<C-O>G
onoremap <C-A> <C-C>ggV<C-O>G
snoremap <C-A> <C-C>ggV<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next tab
vnoremap <C-Tab> :call SwitchTab()<CR>
noremap <C-Tab> :call SwitchTab()<CR>
inoremap <C-Tab> <Esc>:call SwitchTab()<CR>
cnoremap <C-Tab> <Esc>:call SwitchTab()<CR>
onoremap <C-Tab> <Esc>:call SwitchTab()<CR>

" for switching tabs
function! SwitchTab()
	if exists("g:last_tab")
		exe "normal " . g:last_tab . "gt"
	endif
endfunction

" for commenting quickly
fun! UncommentLines()
	let hls=@/
	s#^\(\s*\)//#\1#
	let @/=hls
endfun

fun! CommentLines()
	let hls=@/
	s#^#//#
	let @/=hls
endfun

map ,/ :call CommentLines()<CR>
map ,\ :call UncommentLines()<CR>

" increment/decrement
noremap <C-kMinus> <C-X>
noremap <C-kPlus> <C-A>

function! ExtractMethod(method_name) range
	normal '<"my'>
	
	let new_code = system("php /one45/bin/extractMethod.php " . a:method_name, getreg('m'))
	let [usage, defn] = split(new_code, 'SEPARATOR_OF_EXTRACT_METHOD')

	call setreg('m', usage)
	normal gv"mp==

	call setreg('m', defn)
	exe "normal ]Mo\<cr>\<Esc>"
	normal "mp
endfunction
command! -range -nargs=1 EM   :call ExtractMethod(<q-args>)

noremap <M-c> <C-V>
inoremap <M-c> <Esc><C-V>
cnoremap <M-c> <C-V>
onoremap <M-c> <C-V>

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c

" restore 'cpoptions'
set cpo&
if 1
let &cpoptions = s:save_cpo
unlet s:save_cpo
endif

function! OT(file)
	let l:file1 = "C:/one45/htdocs/mainline/admin/pages/classes/tests/" . a:file . "/unitTest.php"
	let l:file2 = "C:/one45/htdocs/mainline/admin/pages/classes/" . a:file . "/tests/unitTest.php"

	if (filereadable(l:file1))
		exe "tabnew " . l:file1
	elseif (filereadable(l:file2))
		exe "tabnew " . l:file2
	else
		exe "bro tabe"
	endif
endfun

function! NewTest(test_name)
	tabnew
	exe "normal i<?php\<cr>class " . a:test_name . " extends testCase\<cr>{\<cr>}\<cr>?>"
endfun

function! NewView(class_name)
	tabnew
	exe "normal i<?php\<cr>class " . a:class_name . " extends htmlView \<cr>{\<cr>public function main()\<cr>{\<cr>}\<cr>}\<cr>?>"
endfun

function! NewClass(class_name)
	tabnew
	exe "normal i<?php\<cr>class " . a:class_name . " extends \<cr>{\<cr>}\<cr>?>"
endfun

" Do magicky export things
command! -nargs=1 OT   :call OT(<q-args>)
command! -nargs=0 C    :sil bufdo! bd!
command! -nargs=1 NT   :call NewTest(<q-args>)
command! -nargs=1 NC   :call NewClass(<q-args>)
command! -nargs=1 NV   :call NewView(<q-args>)

autocmd BufEnter * exec("cd %:p:h")
autocmd BufEnter * let b:match_words = '<?:?>,(:),[:],{:},<<< \?END:END;,case:break;,<\@<=\([^/][^ \t\:>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
autocmd TabLeave * let g:last_tab = tabpagenr()

set vb t_vb=
autocmd GUIEnter * simalt ~X

" TortoiseSVN integration
" Save the current buffer and execute the Tortoise SVN interface's log
command! -nargs=0 Slog   :silent !"run C:\Progra~1\TortoiseSVN\bin\TortoiseProc.exe /command:log   /path:"%" /notempfile /closeonend"<CR> 
command! -nargs=0 Sdiff  :silent !"run C:\Progra~1\TortoiseSVN\bin\TortoiseProc.exe /command:diff   /path:"%" /notempfile /closeonend"<CR> 
command! -nargs=0 Sblame  :silent !"C:\Progra~1\TortoiseSVN\bin\TortoiseProc.exe /command:blame   /path:"%" /notempfile /closeonend"<CR> 

let @d = "BvE\"ayodump(a, 'a');:w"

" To view a revision from a log
" 0lve"ay:sil !run C:/Progra~1/TortoiseSVN/bin/TortoiseProc.exe /command:log /path:"C:/one45/htdocs/mainline" /startrev:a /endrev:a
