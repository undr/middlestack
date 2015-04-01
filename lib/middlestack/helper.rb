module Middlestack
  module Helper
    class << self
      def included(base)
        base.send(:extend, ClassMethods)
      end
    end

    def run_middlewares(*args, &block)
      self.class.stack.to_app(block).call(*args)
    end

    module ClassMethods
      attr_reader :stack

      def middlewares(&block)
        @stack = Stack.new(&block)
      end
    end
  end
end
