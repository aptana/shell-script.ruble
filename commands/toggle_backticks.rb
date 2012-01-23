require 'ruble'

command t(:toggle_backticks) do |cmd|
  cmd.key_binding = 'M2+M4+\''
  # cmd.scope = 'source.shell string.interpolated'
  cmd.scope = 'source.shell'
  cmd.output = :replace_selection
  cmd.input = :selection, :scope
  cmd.invoke do
    case str = $stdin.read
      when /\A`(.*)`\z/m
        '$(' + $1 + ')'
      when /\A\$\((.*)\)\z/m
        '`' + $1 + '`'
      else str
    end
  end
end
