scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_uniq(list)
	let dict = {}
	for _ in a:list
		let dict[_] = 0
	endfor
	return keys(dict)
endfunction


let s:module = {
\	"name" : "BufferComplete",
\}


function! s:_buffer_complete()
	return sort(s:_uniq(filter(split(join(getline(1, '$')), '\W'), '!empty(v:val)')), 1)
endfunction


function! s:_parse_line(line)
	let keyword = matchstr(a:line, '\zs\w\+\ze$')
	let pos = EasyMotion#helper#strchars(a:line) - EasyMotion#helper#strchars(keyword)
	return [pos, keyword]
endfunction


function! s:_as_statusline(list, count)
	if empty(a:list)
		return
	endif
	let hl_none = "%#StatusLine#"
	let hl_select = "%#StatusLineNC#"
	let tail = " > "
	let result = a:list[0]
	let pos = 0
	if v:version < 703
		let wid = strlen(result . " " . a:list[i])
	else
		let wid = strdisplaywidth(result . " " . a:list[i])
	endif
	for i in range(1, len(a:list)-1)
		if wid > &columns - len(tail)
			if a:count < i
				break
			else
				let pos = -i
			endif
			let result = a:list[i]
		else
			let result .= (" " . a:list[i])
		endif
		if a:count == i
			let pos = pos + i
		endif
	endfor
	return join(map(split(result, " "), 'v:key == pos ? hl_select . v:val . hl_none : v:val'))
endfunction


function! s:module.get_complete_words()
	return s:_buffer_complete()
endfunction


function! s:module.complete(cmdline)
	call s:_finish()
	let s:old_statusline = &statusline

	let backward = a:cmdline.backward()
	let [pos, keyword] = s:_parse_line(backward)

	if !exists("s:complete")
		let s:complete = self.get_complete_words()
	endif
	let s:complete_list = filter(copy(s:complete), 'v:val =~ ''^''.keyword')
	if empty(s:complete_list)
		return -1
	endif

	if pos == 0
		let backward = ""
	else
		let backward = join(split(backward, '\zs')[ : pos-1 ], "")
	endif
	let s:line = backward . a:cmdline.forward()
	let s:pos = pos
	call a:cmdline.setline(s:line)

	let s:count = 0
endfunction


function! s:_finish()
	if exists("s:old_statusline")
		let &statusline = s:old_statusline
		unlet s:old_statusline
		redrawstatus
	endif
endfunction


function! s:module.on_char_pre(cmdline)
	if a:cmdline.is_input("<Over>(buffer-complete)")
		if self.complete(a:cmdline) == -1
			call s:_finish()
			call a:cmdline.setchar('')
			return
		endif
		call a:cmdline.setchar('')
		call a:cmdline.tap_keyinput("Completion")
" 	elseif a:cmdline.is_input("\<Tab>", "Completion")
	elseif a:cmdline.is_input("<Over>(buffer-complete)", "Completion")
\		|| a:cmdline.is_input("\<Right>", "Completion")
		call a:cmdline.setchar('')
		let s:count += 1
		if s:count >= len(s:complete_list)
			let s:count = 0
		endif
	elseif a:cmdline.is_input("\<Left>", "Completion")
		call a:cmdline.setchar('')
		let s:count -= 1
		if s:count < 0
			let s:count = len(s:complete_list) - 1
		endif
	else
		if a:cmdline.untap_keyinput("Completion")
			call a:cmdline.callevent("on_char_pre")
		endif
		call s:_finish()
		return
	endif
	call a:cmdline.setline(s:line)
	call a:cmdline.insert(s:complete_list[s:count], s:pos)
	if len(s:complete_list) > 1
		let &statusline = s:_as_statusline(s:complete_list, s:count)
		redrawstatus
	endif
	if len(s:complete_list) == 1
		call a:cmdline.untap_keyinput("Completion")
	endif
endfunction


function! s:module.on_draw_pre(...)
" 	redrawstatus
endfunction


function! s:module.on_leave(cmdline)
	call s:_finish()
	unlet! s:complete
endfunction

function! s:make()
	return deepcopy(s:module)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
