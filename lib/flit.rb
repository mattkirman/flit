require 'rubygems'
require 'yaml'
require 'highline'


module Flit
  autoload :Help,     'flit/help'
  autoload :Version,  'flit/version'
  
  
  module Commands
    autoload :Base,     "flit/commands"
    autoload :Init,     "flit/commands/init"
  end
  
  
  def self.exec_script!
    if %w(version --version -v).include? ARGV.first
      puts "Flit #{Version::STRING}"
      
    elsif ARGV[0].nil? || %w(help --help -h).include?(ARGV.first)
      puts Help.display
      
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
        puts "flit: '#{command} is not a command. See 'flit help'."
      end
      
    end
  end
  
end


Dir[File.join(File.dirname(__FILE__), 'flit', 'extensions', '*.rb')].each do |extension|
  require extension
end