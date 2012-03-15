require 'ruble'

bundle t(:bundle_name) do |bundle|
  bundle.author = 'Martin Kuehl'
  bundle.contact_email_rot_13 = 'znegva.xhruy@tznvy.pbz'
  bundle.repository = 'git://github.com/aptana/shell-script.ruble.git'
  bundle.description = 'Support for running and editing shell scripts (using the bash dialect).'
  
  # Indentation
  increase_indent = /^\s*(if|elif|else|case)\b|^.*(\{|\b(do)\b)$/
  decrease_indent = /^\s*(\}|(elif|else|fi|esac|done)\b)/
  bundle.indent['source.shell'] = increase_indent, decrease_indent
  
  # Folding
  start_folding = /\b(if|case)\b|(\{|\b(do)\b)$/
  end_folding = /^\s*(\}|(done|fi|esac)\b)/
  bundle.folding['source.shell'] = start_folding, end_folding
  
  # Filetypes
  bundle.file_types['source.shell'] = '*.sh', '*.ss', '*.bashrc', '*.bash_profile', '*.bash_login', '*.profile', '*.bash_logout', '.textmate_init'

  bundle.menu t(:bundle_name) do |main_menu|
    main_menu.command t(:run_script)
    main_menu.command t(:make_script_executable)
    main_menu.command t(:open_terminal)
    main_menu.separator
    main_menu.command t(:docs_for_word)
    main_menu.separator
    main_menu.command t(:new_function)
    main_menu.command t(:here_doc)
    main_menu.command '#!/usr/bin/env'
    main_menu.separator
    main_menu.menu t(:tests) do |submenu|
      submenu.command 'if ... fi'
      submenu.command 'elif ...'
      submenu.command 'case ... esac'
    end
    main_menu.menu t(:loops) do |submenu|
      submenu.command 'for ... done'
      submenu.command 'for ... in ... done'
      submenu.command 'while ... done'
      submenu.command 'until ... done'
    end
    # main_menu.menu 'Idioms' do |submenu|
    #   submenu.command 'Tempfile'
    # end
  end
end

# Extend Ruble::Editor to set special Comment ENV Vars
env "source.shell" do |e|
  e['TM_COMMENT_START'] = "# "
  e.delete('TM_COMMENT_END')
  e.delete('TM_COMMENT_START_2')
  e.delete('TM_COMMENT_END_2')
  e.delete('TM_COMMENT_DISABLE_INDENT')
end