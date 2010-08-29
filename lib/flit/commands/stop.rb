module Flit
  module Commands
    class Stop
      DESC = "Stop work on a feature or bugfix"
      
      def run(args)
        Hooks.fire :didStartCommand__stop
        `git checkout #{open_config[:branches][:bleeding_edge]}`
        Hooks.fire :didFinishCommand__stop
      end
      
    end
  end
end