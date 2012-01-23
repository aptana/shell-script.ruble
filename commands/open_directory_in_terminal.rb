require 'ruble'

command t(:open_terminal) do |cmd|
  cmd.key_binding = 'M2+M4+O'
  cmd.output = :discard
  cmd.input = :none
  cmd.invoke do
    require 'ruble/terminal'
    
    files = [ ENV['TM_SELECTED_FILE'], ENV['TM_FILEPATH'], ENV['TM_DIRECTORY'], ENV['TM_PROJECT_DIRECTORY'], ENV['HOME'] ]
    res = files.find { |file| file && File.exists?(file) }
    dir = res && File.file?(res) ? File.split(res).first : res
    Ruble::Terminal.open(nil, dir)
  end
end
