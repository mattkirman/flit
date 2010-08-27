module Flit
  module Commands
    class Start
      DESC = "Start work on a new feature or bugfix"
      
      def run(args)
        # TODO: Show the help page if no options are set
        
        type, name = args
        config = open_config
        
        branch_name = case type
          when "feature" then config[:branches][:feature_prefix]
          when "bugfix" then config[:branches][:bugfix_prefix]
          else puts "flit: unknown branch type '#{type}'"; exit(0)
        end
        
        branch_name << name
        
        `git branch #{branch_name}` if `git branch`.match(branch_name).nil?
        `git checkout #{branch_name}`
      end
      
    end
  end
end