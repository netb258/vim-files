" Vim indent file
" Language: Ruby
" Maintainer: Gavin Sinclair <gsinclair@soyabean.com.au>
" Last Change: 2003 May 11
" URL: www.soyabean.com.au/gavin/vim/index.html
" Changes: (since vim 6.1)
" - indentation after a line ending in comma, etc, (even in a comment) was
" broken, now fixed (2002/08/14)

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetRubyIndent()
setlocal nolisp
setlocal nosmartindent
setlocal autoindent
setlocal indentkeys+==end,=else,=elsif,=when,=ensure,=rescue,=]

" Only define the function once.
if exists("*GetRubyIndent")
  finish
endif

function GetRubyIndent()
  " Find a non-blank line above the current line.
  let lnum = prevnonblank(v:lnum - 1)
  let prev_line = getline(lnum)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  " If the line trailed with [*+,.(] - but not in a comment - trust the user
  if prev_line =~ '\(\[^#\].*\)?\(\*\|\.\|+\|,\|(\)\(\s*#.*\)\=$'
    return -1
  endif
  let reg = '^\s*\zs\<\%(module\|class\|def\|if\|for' .
      \ '\|while\|until\|else\|elsif\|case\|when\|unless\|begin\|ensure' .
      \ '\|rescue\)\>' .
      \ '\|\%([*+/,=:-]\|<<\|>>\)\s*\zs' .
      \    '\<\%(if\|for\|while\|until\|case\|unless\|begin\)\>'
  " Add a 'shiftwidth' after lines beginning with:
  " module, class, dev, if, for, while, until, else, elsif, case, when, [ and {
  let ind = indent(lnum)
  let flag = 0
  if prev_line =~ reg
        \ || prev_line =~ '\({\|\<do\>\).*|.*|\(\s*#.*\)\=$'
        \ || prev_line =~ '\<do\>\(\s*#.*\)\=$'
    let ind = ind + &sw
    let flag = 1
  endif

  let current_line_num = lnum
  let first_token = synIDattr(synID(current_line_num, indent(lnum) + 1, 0), "name")
  let last_token = synIDattr(synID(current_line_num, len(prev_line), 0), "name")

  " Just common brackets
   let brackets1 = prev_line =~ '{\s*$' || prev_line =~ '[\s*$'
  " Brackets with a trailing comment
   let brackets2 = prev_line =~ '{\(\s*#.*\)\=$' || prev_line =~ '[\(\s*#.*\)\=$'

   if brackets1 || (brackets2 && last_token =~ "rubyComment")
     let ind = ind + &sw
     let flag = 1
   endif

  " Subtract a 'shiftwidth' after lines ending with
  " "end" when they begin with while, if, for, until
  if flag == 1 && prev_line =~ '\<end\>\(\s*#.*\)\=$'
    let ind = ind - &sw
  endif

  " Subtract a 'shiftwidth' on end, else and, elsif, when, ] and }
  if getline(v:lnum) =~ '^\s*\(end\>\|else\>\|elsif\>\|when\>\|ensure\>\|rescue\>\|}\)' || getline(v:lnum) =~ '^\s*\]'
    return ind - &sw
  endif

  " Do not indent comments
  if (first_token =~ "rubyComment") 
    return indent(lnum)
  endif

  return ind
endfunction

" vim:sw=2
