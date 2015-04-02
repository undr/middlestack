module Middlestack
  module Helper
    class << self
      def included(base)
        base.send(:extend, ClassMethods)
      end
    end

    def run_middlewares(*args, &block)
      block = ->(env){ run(env) } unless block_given?
      self.class.stack.to_app(block).call(*args)
    end

    def run(*args)
    end

    module ClassMethods
      attr_reader :stack

      def middlewares(&block)
        @stack = Stack.new(&block)
      end
    end
  end
end
