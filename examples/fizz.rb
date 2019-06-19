# frozen_string_literal: true

require './lib/fizzlang'

module Examples
  # A class used to demonstrate how class methods can be called
  # outside the class declaration and provide the same result.
  class Fizz
    include FizzLang
  end
  Fizz.test_cases(:Fizz)
  Fizz.Fizz(3)
end
