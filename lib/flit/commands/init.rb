module Flit
  module Commands
    class Init
      DESC = "Create a new Flit repository. Must be run from the top level directory in your Git repository."
      
      def run
        # Don't allow us to reinitialise an existing Flit repository
        if is_flit?
          fatal "directory is already a flit repository"
        end
        
        # Don't allow us to reinitialise an existing Git repository
        unless is_git?
          puts "Creating a new repository..."
          `git init`
        end
        
        
        # Set up our initial config
        puts "No branches exist yet. Base branches must be created now."
        
        h = HighLine.new
        
        bleeding_edge_branch_name = h.ask("Branch name for bleeding edge development: ") { |q| q.default = 'master' }
        staging_branch_name = h.ask("Branch name for staging releases: ") { |q| q.default = 'staging' }
        production_branch_name = h.ask("Branch name for production releases: ") { |q| q.default = 'production' }
        
        puts "Name your supporting branch prefixes."
        
        feature_branch_prefix = h.ask("Feature branches? ") { |q| q.default = 'feature/' }
        bugfix_branch_prefix = h.ask("Bugfix branches? ") { |q| q.default = 'bugfix/' }
        version_tag_prefix = h.ask("Version tag prefix? ") { |q| q.default = 'v' }
        
        
        # Save our config
        save_config ({
          :branches => {
            :bleeding_edge => bleeding_edge_branch_name,
            :staging => staging_branch_name,
            :production => production_branch_name,
            :feature_prefix => feature_branch_prefix,
            :bugfix_prefix => bugfix_branch_prefix
          },
          :tags => {
            :version_prefix => version_tag_prefix
          }
        })
        
        # Repository created!
      end
      
    end
  end
end