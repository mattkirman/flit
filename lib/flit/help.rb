module Flit
  class Help
    USAGE = <<USAGE
Usage:
  flit COMMAND [options]

Commands:
  {{commands}}
  
  help                # Show this page
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
          begin
            command = f.gsub(/\.rb/, '')
            klass = "Flit::Commands::#{command.camelize}"
            commands << "#{command.ljust(20)}# #{ eval("#{klass}::DESC") }"
          rescue
          end
        end
      end
      
      commands.sort.join("\n  ")
    end
    
  end
end