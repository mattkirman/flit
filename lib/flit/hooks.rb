require 'singleton'

module Flit
  class Hooks
    include Singleton
    
    @hooks = {}
    
    def load!
      Dir[File.join(`pwd`.gsub(/\n/, ''), '.flit', 'hooks', '*.rb')].each do |hookfile|
        hook = File.open(hookfile, 'r').read
        instance_eval(hook, hookfile || "(eval)")
      end
    end
    
    def bind(*args, &block)
      args = parse_args args
      @hooks = {} if @hooks.nil?
      
      @hooks[args[:on]] = [] if @hooks[args[:on]].nil?
      @hooks[args[:on]] << block
    end
    
    def parse_args(args)
      arguments = {}
      args.each do |a|
        a.each do |c, d|
          arguments[c] = d
        end
      end
      arguments
    end
    
    def fire(e, args = {})
      unless @hooks[e].nil?
        @hooks[e].each do |hook|
          hook.call args
        end
      end
    end
    
    def self.fire(e, args = {})
      instance.fire e, args
    end
    
  end
end