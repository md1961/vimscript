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


" tabs : ['Tab page 1', '    vimrc', '    vimrc_ruby', 'Tab page 2', '   usr_41.txt', 'Tab page 3', '> + toggle_tab_win.vim']
" args : 'vimrc_ruby usr_41.txt [toggle_tab_win.vim]'
" @#   : alternate file
:function s:ToggleTabWin()
  :redir => s:tabs
    :silent tabs
  :redir END
  :let s:lines = split(s:tabs, "\n")

  :let s:files_by_tab = []
  :let s:index_current_tab = -1
  :for s:line in s:lines
    :if match(s:line, "^Tab page ") >= 0
      :if exists("s:files_in_tab") && len(s:files_in_tab) > 0
        :call add(s:files_by_tab, s:files_in_tab)
      :endif
      :let s:files_in_tab = []
    :else
      :call add(s:files_in_tab, s:line)
      :if match(s:line, "^>") >= 0
        :let s:index_current_tab = len(s:files_by_tab)
      :endif
    :endif
  :endfor
  :call add(s:files_by_tab, s:files_in_tab)
  " Must reset variable because it keeps existing for next script execution.
  :let s:files_in_tab = []

  :let s:is_single_file_opened = len(s:files_by_tab) == 1 && len(s:files_by_tab[0]) == 1
  :let s:num_files_in_current_tab = len(s:files_by_tab[s:index_current_tab])
  :if s:is_single_file_opened
    :let s:alt_file = @#
    :if s:alt_file > ''
      :execute 'split ' . s:alt_file
    :else
      :redir => s:args
        :silent args
      :redir END
      :let s:args = substitute(s:args, "\n", "", "g")
      :let s:files = split(s:args, ' ')
      :if len(s:files) == 1
        :echo "Nothing to do because a single file exists to edit"
      :else
        :let s:first_chars_in_files = map(copy(s:files), 'strpart(v:val, 0, 1)')
        :let s:index_next_file = index(s:first_chars_in_files, "[") + 1
        :if s:index_next_file >= len(s:files)
          :let s:index_next_file = 0
        :endif
        :execute 'split ' . s:files[s:index_next_file]
        "TODO: What about rest of files when num files >= 3
      :endif
    :endif
  :elseif s:num_files_in_current_tab == 1
    :let s:index_next_tab = s:index_current_tab + 1
    :if s:index_next_tab >= len(s:files_by_tab)
      :let s:index_next_tab = 0
    :endif
    :let s:files_in_next_tab = s:files_by_tab[s:index_next_tab]
    :tabnext
    " Go to bottom window.
    :wincmd b
    :let s:file_to_open = @%
    :close
    :if len(s:files_in_next_tab) > 1
      :tabprevious
    :endif
    :execute 'split ' . s:file_to_open
    :wincmd w
  :else
    :wincmd W
    :let s:file_to_open = @%
    :close
    :execute 'tabedit ' . s:file_to_open
    :tabprevious
  :endif
:endfunction


:if ! exists(":ToggleTabWin")
  :command ToggleTabWin :call s:ToggleTabWin()
:endif


" Restore the 'cpoptions' values
let &cpo = s:save_cpo
