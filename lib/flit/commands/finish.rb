module Flit
  module Commands
    class Finish
      DESC = "Finish up a feature or bugfix and merge it back into the development branch"
      USAGE = "TYPE NAME"
      OPTIONS = {
        :type => "Can be either a feature or bugfix",
        :name => "The name of your feature or bugfix",
      }
      
      def run(args)
        # Gatekeepers
        fatal "directory isn't a flit repository" unless is_flit?
        show_help unless args.count == 2
        
        type, name = args
        config = open_config
        
        current_branch = nil
        `git branch`.split("\n").each do |branch|
          if branch[0,1] == '*'
            current_branch = branch[2..-1].downcase.split('/')
          end
        end
        
        #`git checkout #{type}/#{name}` unless type == current_type && name == current_name
        
        `git checkout #{config[:branches][:bleeding_edge]}` unless current_branch[0] == config[:branches][:bleeding_edge]
        `git pull`
        `git checkout #{type}/#{name}`
        `git merge master`
        
        # Todo: do merge conflict detection here
        
        `git checkout #{config[:branches][:bleeding_edge]}`
        `git merge #{type}/#{name}`
        
        puts "\nMerged '#{type}/#{name}' into '#{config[:branches][:bleeding_edge]}'."
        puts "You should now 'git push' your changes."
      end
      
    end
  end
end