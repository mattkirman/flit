module Flit
  module Commands
    class List
      DESC = "Allows you to view an outline of ongoing features and bugfixes in your Git repo.
If TYPE is not specified, 'list' will show you details of both features and bugfixes."
      USAGE = "[TYPE]"
      OPTIONS = {
        :type => "Can be either a feature or bugfix",
      }
      
      def run(args)
        # Gatekeeper
        fatal "directory isn't a flit repository" unless is_flit?
        
        Hooks.fire :didStartCommand__list
        
        type = args[0]
        unless type.nil? || type == 'feature' || type == 'bugfix'
          show_help
        end
        
        config = open_config
        feature_branches = []
        bugfix_branches = []
        other_branches = []
        
        `git branch`.split("\n").each do |branch|
          indicator = (branch[0,1] == '*') ? '  => ' : '     '
          branch = branch[2..-1].downcase
          split_branch = branch.split('/')
          
          if branch.include?(config[:branches][:feature_prefix])
            feature_branches << "#{indicator}#{split_branch[1..-1].join('/')}"
          elsif branch.include?(config[:branches][:bugfix_prefix])
            bugfix_branches << "#{indicator}#{split_branch[1..-1].join('/')}"
          else
            other_branches << "#{indicator}#{branch}"
          end
        end
        
        list_branches "Features", feature_branches unless type == 'bugfix'
        list_branches "Bugfixes", bugfix_branches unless type == 'feature'
        list_branches "Other", other_branches if type.nil?
        
        Hooks.fire :didFinishCommand__list
      end
      
      private
      def list_branches(type, branches)
        if branches.count > 0
          puts "#{type}:"
          branches.each {|f| puts f}
          puts ""
        end
      end
      
    end
  end
end