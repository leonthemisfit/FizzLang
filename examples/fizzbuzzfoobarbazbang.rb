# frozen_string_literal: true

require './lib/fizzlang'

module Examples
  # Example class used to demonstrate using many test cases
  class FizzBuzzFooBarBazBang
    include FizzLang

    test_cases :fizz, :buzz, :foo, :bar, :baz, :bang

    fizz 3, 'Fizz'
    buzz 5, 'Buzz'
    foo 7, 'Foo'
    bar 9, 'Bar'
    baz 11, 'Baz'
    bang 13, 'Bang'
  end
end
