# Middlestack

The Middlestack is a simple and convenient way to build and run of your own middleware stack for ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middlestack'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install middlestack
```

## Usage

It's pretty simple.

```ruby
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

Executor.new.execute
# => ['->A', '->B', '->C', 'run', '<-C', '<-B', '<-A']
```

That's all. Have a nice code!

## Contributing

1. Fork it ( https://github.com/undr/middlestack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
