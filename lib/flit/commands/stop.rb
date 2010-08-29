module Flit
  module Commands
    class Stop
      DESC = "Stop work on a feature or bugfix"
      
      def run(args)
        `git checkout #{open_config[:branches][:bleeding_edge]}`
      end
      
    end
  end
end