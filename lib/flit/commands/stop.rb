module Flit
  module Commands
    class Stop
      DESC = "Stop work on a feature of bugfix"
      
      def run(args)
        # TODO: Show the help page if no options are set
        
        `git checkout #{open_config[:branches][:bleeding_edge]}`
      end
      
    end
  end
end