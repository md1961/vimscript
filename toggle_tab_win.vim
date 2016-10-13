" Vim global plugin for converting tabs to windows, or vice versa
" Last Change:	2016 Oct 13
" Maintainer:	Naoyuki Kumagai <naoyuki.kumagai@japex.co.jp>
" License:	This file is placed in the public domain.

" Not loading mechanism
:if exists("loaded_toggle_tab_win")
  :finish
:endif
:let loaded_toggle_tab_win = 1

" Save the 'cpoptions' values
:let s:save_cpo = &cpo
:set cpo&vim


:function s:ApplyExceptCurrent(items, index_current, command)
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


:function s:ToggleTabWin()
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
      :call s:ApplyExceptCurrent(s:files, s:index_current_file, ":tabedit")
      :tabnext
    :endif
  :else
    :if len(s:lines) != len(s:files) * 2
      :echo "Quit execution because there is another tab with multiple windows"
    :else
      :tabonly
      :call s:ApplyExceptCurrent(s:files, s:index_current_file, ":split")
      :wincmd w
    :endif
  :endif
:endfunction


:if ! exists(":ToggleTabWin")
  :command ToggleTabWin :call s:ToggleTabWin()
:endif


" Restore the 'cpoptions' values
let &cpo = s:save_cpo
