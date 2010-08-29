module Flit
  module Commands
    class Delete
      DESC = "Delete a feature or bugfix branch"
      USAGE = "TYPE NAME"
      OPTIONS = {
        :type => "Can be either a feature or bugfix",
        :name => "The name of your feature or bugfix",
      }
      
      def run(args)
        
      end
      
    end
  end
end