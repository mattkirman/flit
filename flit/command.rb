module Flit
  def self.command(name)
    yield Flit::Command.new(name, ARGV[1..-1])
  end
  
  
  class Command
    
    attr_accessor :args
    
    
    def initialize(name, args)
      @command_name = name
      @args = args
      @working_directory = `pwd`.gsub("\n", '')
    end
    
    
    def fatal(string)
      puts "fatal: #{string}"
      exit(0)
    end
    
    
    def is_git?(path = nil)
      path ||= "#{@working_directory}/.git"
      return File.directory? path
    end
    
  end
end