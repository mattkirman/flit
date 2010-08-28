module Flit
  module Commands
    module Base
      
      def working_directory
        `pwd`.gsub("\n", '')
      end
      
      
      def fatal(string)
        puts "fatal: #{string}"
        exit(0)
      end
      
      
      def is_flit?(path = nil)
        path ||= "#{working_directory}/.flit_config"
        File.exists? path
      end
      
      
      def is_git?(path = nil)
        path ||= "#{working_directory}/.git"
        File.directory? path
      end
      
      
      def save_config(config)
        File.open(".flit_config",'w') { |f| f.puts config.to_yaml }
      end
      
      
      def open_config
        YAML::load(File.open('.flit_config'))
      end
      
      
      def show_help
        puts Flit::Help.display_for_command(self.class.name)
        exit(0)
      end
      
    end
  end
end