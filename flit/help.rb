module Flit
  module Help
    USAGE = <<USAGE
Usage:
  flit COMMAND [options]

Commands:
  {{commands}}
  
  -h, --help          # Show this page
  -v, --version       # Get Flit version information

USAGE
    
    
    def self.display
      return USAGE.gsub("{{commands}}", available_commands)
    end
    
    
    def self.available_commands
      commands_dir = File.expand_path('../commands', __FILE__)
      commands = []
      Dir.new(commands_dir).each do |f|
        if f.match(/(.*)\.rb/)
          command = f.gsub(/\.rb/, '')
          commands << command.ljust(20)
        end
      end
      
      commands.join("\n  ")
    end
    
  end
end