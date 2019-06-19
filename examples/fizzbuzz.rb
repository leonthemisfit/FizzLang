# frozen_string_literal: true

require './lib/fizzlang'

# Module containing all of the example classes
module Examples
  # The classic Fizz Buzz
  # * +Fizz+ is 3
  # * +Buzz+ is 5
  class FizzBuzz
    include FizzLang

    test_cases :Fizz, :Buzz

    Fizz 3
    Buzz 5
  end
end
