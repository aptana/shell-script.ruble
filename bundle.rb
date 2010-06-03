require 'ruble'

bundle 'Shell Script' do |bundle|
  bundle.author = 'Martin Kuehl'
  bundle.contact_email_rot_13 = 'znegva.xhruy@tznvy.pbz'
  bundle.description =  <<END
Support for running and editing shell scripts (using the bash dialect).
END
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

  bundle.menu 'Shell Script' do |main_menu|
    main_menu.command 'Run Script'
    main_menu.command 'Make Script Executable'
    main_menu.command 'Open Terminal'
    main_menu.separator
    main_menu.command 'Documentation for Word / Selection'
    main_menu.separator
    main_menu.command 'New Function'
    main_menu.command 'Here Document'
    main_menu.command '#!/usr/bin/env'
    main_menu.separator
    main_menu.menu 'Tests' do |submenu|
      submenu.command 'if ... fi'
      submenu.command 'elif ...'
      submenu.command 'case ... esac'
    end
    main_menu.menu 'Loops' do |submenu|
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
module Ruble
  class Editor
    unless method_defined?(:modify_env_pre_shell_script_bundle)
      alias :modify_env_pre_shell_script_bundle :modify_env
      def modify_env(scope, env)
        env_hash = modify_env_pre_shell_script_bundle(scope, env)
        if scope.start_with? "source.shell"
          env_hash['TM_COMMENT_START'] = "# "
          env_hash.delete('TM_COMMENT_END')
          env_hash.delete('TM_COMMENT_START_2')
          env_hash.delete('TM_COMMENT_END_2')
          env_hash.delete('TM_COMMENT_DISABLE_INDENT')
        end
        env_hash
      end
    end
  end
end