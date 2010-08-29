module Flit
  module Commands
    class Delete
      DESC = "Delete a feature or bugfix branch. Use with caution."
      USAGE = "TYPE NAME"
      OPTIONS = {
        :type => "Can be either a feature or bugfix",
        :name => "The name of your feature or bugfix",
      }
      
      def run(args)
        # Gatekeepers
        fatal "directory isn't a flit repository" unless is_flit?
        show_help unless args.count == 2
        
        Hooks.fire :didStartCommand__delete
        
        type, name = args
        config = open_config
        
        h = HighLine.new
        
        if h.agree("Delete #{type} branch '#{name}'? [yn]", true)
          `git branch -d #{type}/#{name}`
        end
        
        Hooks.fire :didFinishCommand__delete, {:type => type, :name => name}
      end
      
    end
  end
end