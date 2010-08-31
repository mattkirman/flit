module Flit
  module Commands
    class Version
      DESC = "Mark the current commit as a new version. Creates a new annotated tag."
      USAGE = "VERSION [MESSAGE]"
      OPTIONS = {
        :version => "Should be a version string in the form X.Y.Z",
        :message => "An optional message to add to the tag. Defaults to 'Bump to X.Y.Z'"
      }
      
      def run(args)
        # Gatekeepers
        fatal "directory isn't a flit repository" unless is_flit?
        show_help unless args.count >= 1
        
        Hooks.fire :didStartCommand__version
        
        config = open_config
        version, message = args
        message ||= "Bump to #{config[:tags][:version_prefix]}#{version}"
        
        `git tag -a #{config[:tags][:version_prefix]}#{version} -m "#{message}"`
        
        Hooks.fire :didFinishCommand__version
      end
      
    end
  end
end