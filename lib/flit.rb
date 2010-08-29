require 'rubygems'
require 'yaml'
require 'highline'


module Flit
  autoload :Help,     'flit/help'
  autoload :Version,  'flit/version'
  
  
  module Commands
    autoload :Base,     "flit/commands"
    autoload :Init,     "flit/commands/init"
    autoload :Start,    "flit/commands/start"
    autoload :Stop,     "flit/commands/stop"
    autoload :Finish,   "flit/commands/finish"
    autoload :Delete,   "flit/commands/delete"
    autoload :Version,  "flit/commands/version"
  end
  
  
  def self.exec_script!
    if %w(--version -v).include? ARGV.first
      puts "Flit #{Version::STRING}"
      
    elsif ARGV[0].nil? || %w(help --help -h).include?(ARGV.first)
      puts (ARGV[1].nil?) ? Help.display : Help.display_for_command(ARGV[1])
      
    else
      command = ARGV.first
      
      begin
        klass = eval "Commands::#{command.camelize}.new"
        klass.extend Commands::Base
        begin
          klass.run ARGV[1..-1]
        rescue
          klass.run
        end
      rescue
        puts "flit: '#{command}' is not a command. See 'flit help'."
      end
      
    end
  end
  
end


# Load our custom extensions
Dir[File.join(File.dirname(__FILE__), 'flit', 'extensions', '*.rb')].each do |extension|
  require extension
end