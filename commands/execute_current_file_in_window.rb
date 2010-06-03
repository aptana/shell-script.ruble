require 'ruble'
require 'ruble/terminal'

command 'Run Script' do |cmd|
  cmd.key_binding = 'M1+R'
  cmd.scope = 'source.shell'
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke do
    # TODO Save current file
    # TODO Get working dir as parent of file
    Ruble::Terminal.open("\""+ENV["TM_FILEPATH"]+"\"")
  end
end

