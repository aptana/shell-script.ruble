require 'ruble'

command t(:run_script) do |cmd|
  cmd.key_binding = 'M1+R'
  cmd.scope = 'source.shell'
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke do
    require 'ruble/terminal'
    # TODO Save current file
    # TODO Get working dir as parent of file
    Ruble::Terminal.open("\""+ENV["TM_FILEPATH"]+"\"")
  end
end

