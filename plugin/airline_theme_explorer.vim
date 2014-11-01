" Define function once only
if exists('loaded_airlie_theme_explorer') || &cp
  finish
endif

let loaded_airlie_theme_explorer = 1

" Create commands
if !exists(":AirlineThemeExplorer")
  command AirlineThemeExplorer :call <SID>AirlineThemeExplorer()
endif

" AirlineThemeExplorer {{{1
function! <SID>AirlineThemeExplorer()
  let s:color_file_list = globpath(&runtimepath, '*/airline/themes/*.vim')
  let s:color_file_list = substitute(s:color_file_list, '\', '/', 'g')

  silent bot 10new "Airline Theme Explorer"

  setlocal bufhidden=delete
  setlocal buftype=nofile
  setlocal modifiable
  setlocal noswapfile
  setlocal nowrap

  map <buffer> <silent> ? :call <SID>ToggleHelp()<cr>
  map <buffer> <silent> <cr> :call <SID>SelectScheme()<cr>
  map <buffer> <silent> <space> :call <SID>SelectScheme()<cr>j
  map <buffer> <silent> <2-leftmouse> :call <SID>SelectScheme(0)<cr>
  map <buffer> <silent> q :bd!<cr>

  silent! put! =s:color_file_list

  unlet! s:color_file_list

  setlocal nomodifiable
endfunction

" SelectScheme {{{1
function! <SID>SelectScheme()
  " Are we on a line with a file name?
  if strlen(getline('.')) == 0
    return
  endif

  call <SID>Reset()

  execute "AirlineTheme" fnamemodify(getline('.'), ":t:r")
endfunction

" Reset {{{1
function! <SID>Reset()
endfunction

" ToggleHelp {{{1
function! <SID>ToggleHelp()
  " Save position
  normal! mZ

  let header = "\" Press ? for Help\n"
  silent! put! =header

  " Jump back where we came from if possible.
  0
  if line("'Z") != 0
    normal! `Z
  endif
endfunction

"----------------------------------------------------------"
"call <SID>AirlineThemeExplorer()

" vim:ft=vim foldmethod=marker
