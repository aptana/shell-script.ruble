require 'ruble'

command t(:new_function) do |cmd|
  cmd.key_binding = 'M2+ENTER'
  cmd.scope = 'source.shell'
  cmd.trigger = 'fun'
  cmd.output = :insert_as_snippet
  cmd.input = :selection, :word
  cmd.invoke do
    
    function_name = $stdin.read

    if function_name.empty? || function_name.nil?
      function_name = "function_name"  
    end
    
    <<-SNIPPET
function #{function_name} () {
  #statements
}   
    SNIPPET

  end
end
