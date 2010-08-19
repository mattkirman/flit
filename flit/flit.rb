require 'version'
require 'help'
require 'command'
require 'string'
require 'yaml'

require 'rubygems'
require 'highline'


module Flit
  module Cli
    
    def self.exec_script!
      if %w(--version -v).include? ARGV.first
        puts "Flit #{Flit::Version::STRING}"
        
      elsif ARGV[0].nil? || %w(--help -h).include?(ARGV.first)
        puts Flit::Help.display
        
      else
        command = ARGV.first
        
        #begin
          load "#{File.dirname(__FILE__)}/commands/#{command}.rb"
        #rescue
        #  puts "flit: '#{command}' is not a command. See 'flit --help'."
        #  exit(0)
        #end
        
      end
    end
    
  end
end