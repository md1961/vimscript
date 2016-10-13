:function! s:apply_except_current(items, index_current, command)
  :let s:i = a:index_current + 1
  :while 1
    :if s:i == a:index_current
      :break
    :elseif s:i >= len(a:items)
      :let s:i = 0
    :else
      :execute a:command . " " . a:items[s:i]
      :let s:i += 1
    :endif
  :endwhile
:endfunction


:redir => s:var
  :silent tabs
:redir END

:let s:lines = split(s:var, "\n")
:let s:tab_page_indexes = filter(copy(s:lines), 'match(v:val, "Tab page ") >= 0')
:let s:is_single_tab = len(s:tab_page_indexes) == 1
:let s:files = filter(copy(s:lines), 'match(v:val, "^[> ]") >= 0')
:let s:first_chars_in_files = map(copy(s:files), 'strpart(v:val, 0, 1)')
:let s:index_current_file = index(s:first_chars_in_files, '>')
:call map(s:files, 'substitute(v:val, "^>*  *", "", "")')

:if s:is_single_tab
  :if len(s:files) <= 1
    :echo "Nothing to do because a single file is opened"
  :else
    :only
    :call s:apply_except_current(s:files, s:index_current_file, ":tabedit")
    :tabnext
  :endif
:else
  :if len(s:lines) != len(s:files) * 2
    :echo "Quit execution because there is a tab with multiple windows"
  :else
    :tabonly
    :call s:apply_except_current(s:files, s:index_current_file, ":split")
    :wincmd w
  :endif
:endif
