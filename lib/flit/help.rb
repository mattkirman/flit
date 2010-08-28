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
      USAGE.gsub("{{commands}}", available_commands)
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
    
    
    def self.display_for_command(klass)
      command = klass.split(/::/)[-1].downcase
      
      help = "Usage:\n  flit #{command}"
      begin
        help << " #{eval("#{klass}::USAGE")}"
      rescue
      end
      
      begin
        options = eval("#{klass}::OPTIONS")
        unless options.count == 0
          help << "\n\nOptions:"
          options.each do |opt, desc|
            help << "\n  #{opt.to_s.ljust(20)}# #{desc}"
          end
        end
      rescue
      end
      
      "#{help}\n "
    end
    
  end
end