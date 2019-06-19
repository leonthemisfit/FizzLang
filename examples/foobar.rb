# frozen_string_literal: true

require './lib/fizzlang'

module Examples
  # A variation of Fizz Buzz replacing fizz and buzz with
  # foo and bar respectively
  # * +Foo+ is 5
  # * +Bar+ is 10
  class FooBar
    include FizzLang

    test_cases :Foo, :Bar

    Foo 5
    Bar 10
  end
end
