" Find file, and if there are several then ask the user which one is
" intended.
function! O(file)
	if (a:file == '.')
		let l:file = expand('<cword>')
	else
		let l:file = a:file
	endif

	let l:matches = system("bash /bin/one45_find " . l:file)

	if (l:matches == '')
		bro tabe
	else
		exe "tabnew " . l:matches
	endif
endfun

function! S(file)
	if (a:file == '.')
		let l:file = expand('<cword>')
	else
		let l:file = a:file
	endif

	let l:matches = system("bash /bin/one45_find " . l:file)

	if (l:matches == '')
		bro vs
	else
		exe "vs " . l:matches
	endif
endfun

" Do magicky export things
command! -nargs=1 O   :call O(<q-args>)
command! -nargs=1 S   :call S(<q-args>)
