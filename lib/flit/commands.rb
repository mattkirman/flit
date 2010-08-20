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
        return File.exists? path
      end
      
      
      def is_git?(path = nil)
        path ||= "#{working_directory}/.git"
        return File.directory? path
      end
      
      
      def save_config(config)
        File.open("#{working_direcoty}/.flit_config",'w') { |file| file.puts config.to_yaml }
      end
      
    end
  end
end