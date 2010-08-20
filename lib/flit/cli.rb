path = File.expand_path('../', __FILE__)
$:.unshift(path)

require 'flit'

Signal.trap("INT") { puts; exit }

Flit.exec_script!
