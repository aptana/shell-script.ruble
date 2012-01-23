require 'ruble'

command t(:docs_for_word) do |cmd|
  #cmd.key_binding = 'M4+H'
  cmd.output = :show_as_tooltip
  cmd.input = :selection, :word
  cmd.invoke =<<-EOF
#!/bin/bash
word=${TM_SELECTED_TEXT:-$TM_CURRENT_WORD}

try_help () {
	if help "$word" &>/dev/null; then
		source "$TM_SUPPORT_PATH/lib/webpreview.sh"
		html_header "Documentation for \"$word\""
		help "$word" | pre
		html_footer
		exit_show_html
	elif man -w "$word" &>/dev/null; then
		page=$("$TM_SUPPORT_PATH/bin/html_man.sh" -a "$word")
		echo "<meta http-equiv='Refresh' content='0;URL=tm-file://$page'>"
		exit_show_html
	fi
}

MANSECT=${MANSECT:-2:3:4:5:6:7:8:9} try_help
try_help

echo "Couldn't find documentation for '${word}'"

EOF
end
