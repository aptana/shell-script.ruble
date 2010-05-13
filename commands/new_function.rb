require 'ruble'

command 'New Function' do |cmd|
  cmd.key_binding = 'M2+ENTER'
  cmd.scope = 'source.shell'
  cmd.trigger = 'fun'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :word
  cmd.invoke =<<-EOF
#!/bin/bash
NAME="$(cat)"
if [[ -z "$NAME" ]]; then
	NAME='${1:function_name}'
fi

cat <<SNIPPET
function $NAME () {
	\${0:#statements}
}
SNIPPET
EOF
end
