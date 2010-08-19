path = File.expand_path('../', __FILE__)
puts path
$:.unshift(path)

require 'flit'

Signal.trap("INT") { puts; exit }

Flit::Cli.exec_script!
