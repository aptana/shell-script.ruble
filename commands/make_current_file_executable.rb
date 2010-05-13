require 'ruble'

# TODO Don't show/define on windows?
command 'Make Script Executable' do |cmd|
  cmd.key_binding = 'M1+M2+M4+X'
  cmd.output = :show_as_tooltip
  cmd.input = :none
  cmd.invoke =<<-EOF
#!/bin/bash
if chmod +x "${TM_FILEPATH}" && [[ -x "${TM_FILEPATH}" ]]
   then echo "${TM_FILEPATH} is now executable"
   else echo "Failed making ${TM_FILEPATH} executable"
fi
EOF
end
