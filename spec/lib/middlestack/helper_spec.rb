require 'spec_helper'

class TraceValue < Struct.new(:env, :value)
  def before
    env << ('->' + value)
  end

  def after
    env << ('<-' + value)
  end
end

class Executor
  include Middlestack::Helper

  middlewares do
    use TraceValue, 'A'
    use TraceValue, 'B'
    use TraceValue, 'C'
  end

  def execute
    run_middlewares([]){|env| env << 'run' }
  end
end

RSpec.describe Middlestack::Helper do
  describe '#run_middlewares' do
    subject{ Executor.new }
    specify{ expect(subject.execute).to eq(['->A', '->B', '->C', 'run', '<-C', '<-B', '<-A']) }
  end
end
