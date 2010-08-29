require 'singleton'

module Flit
  class Hooks
    include Singleton
    
    @hooks = {}
    
    def load!
      # Load hooks on a per-repository basis
      Dir[File.join(`pwd`.gsub(/\n/, ''), '.flit', 'hooks', '*.rb')].each do |file|
        load_file file
      end
      
      # Load hooks in the user's home directory
      Dir[File.join(`cd ~ && pwd`.gsub(/\n/, ''), '.flit', 'hooks', '*.rb')].each do |file|
        load_file file
      end
    end
    
    def bind(*args, &block)
      args = parse_args args
      @hooks = {} if @hooks.nil?
      
      @hooks[args[:on]] = [] if @hooks[args[:on]].nil?
      @hooks[args[:on]] << block
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
    
    private
    def load_file(file)
      hook = File.open(file, 'r').read
      instance_eval(hook, file || "(eval)")
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
    
  end
end