require 'ruble'

command '#!/usr/bin/env' do |s|
  s.trigger = '!env'
  s.input = :none
  s.output = :insert_as_snippet
  s.invoke do
    scope = ENV['TM_SCOPE']
    cmd = 'bash'
    if scope.start_with? 'source.'
      scope = scope[7..-1]
      index = [scope.index('.'), scope.index(' ')].reject {|i| i.nil?}.min
      cmd = scope
      cmd = scope[0...index] if !index.nil?
    end
    cmd = 'bash' if cmd == 'shell'
    "#!/usr/bin/env ${1:#{cmd}}\n"
  end
end

with_defaults :scope => 'source.shell' do
snippet 'case ... esac' do |s|
  s.trigger = 'case'
  s.expansion = 'case ${1:word} in
	${2:pattern} )
		$0;;
esac'
end

snippet 'elif ...' do |s|
  s.trigger = 'elif'
  s.expansion = 'elif [[ ${1:condition} ]]; then
	${0:#statements}'
end

snippet 'for ... done' do |s|
  s.trigger = 'for'
  s.expansion = 'for (( i = 0; i < ${1:10}; i++ )); do
	${0:#statements}
done'
end

snippet 'for ... in ... done' do |s|
  s.trigger = 'forin'
  s.expansion = 'for ${1:i} in ${2:words}; do
	${0:#statements}
done'
end

snippet t(:here_doc) do |s|
  s.trigger = 'here'
  s.expansion = '<<-\'${1:TOKEN}\'
	$0
${1}'
end

snippet 'if ... fi' do |s|
  s.trigger = 'if'
  s.expansion = 'if [[ ${1:condition} ]]; then
	${0:#statements}
fi'
end

# FIXME Not currently working due to unsupported TextMate functionality
# snippet 'Tempfile' do |s|
  # s.trigger = 'temp'
  # s.expansion = '${1:TMPFILE}="$(mktemp -t ${2:`echo "${TM_FILENAME%.*}" | sed -e \'s/[^a-zA-Z]/_/g\' -e \'s/^$/untitled/\'`})"
# ${3:${4/(.+)/trap "/}${4:rm -f \'\$${1/.*\s//}\'}${4/(.+)/" 0               # EXIT
# /}${5/(.+)/trap "/}${5:rm -f \'\$${1/.*\s//}\'; exit 1}${5/(.+)/" 2       # INT
# /}${6/(.+)/trap "/}${6:rm -f \'\$${1/.*\s//}\'; exit 1}${6/(.+)/" 1 15    # HUP TERM
# /}}
# '
# end

snippet 'until ... done' do |s|
  s.trigger = 'until'
  s.expansion = 'until [[ ${1:condition} ]]; do
	${0:#statements}
done'
end

snippet 'while ... done' do |s|
  s.trigger = 'while'
  s.expansion = 'while [[ ${1:condition} ]]; do
	${0:#statements}
done'
end

end
