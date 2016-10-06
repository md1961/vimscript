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

    :let s:i = s:index_current_file + 1
    :while 1
      :if s:i == s:index_current_file
        :break
      :elseif s:i >= len(s:files)
        :let s:i = 0
      :else
        :execute ":tabedit " . s:files[s:i]
        :let s:i += 1
      :endif
    :endwhile
  :endif
:else
  :echo s:lines
  :echo s:files
  :echo "index current = " . s:index_current_file
:endif
":execute ":sp " . s:lines[1]
