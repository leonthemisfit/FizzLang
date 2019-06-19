# frozen_string_literal: true

require './lib/fizzlang'

module Examples
  # Example class used to demonstrate using the shortened form of the original
  # class methods used to setup the class
  class ShorterBarBaz
    include FizzLang

    test_cases :bar, :baz

    bar 3, 'Bar'
    baz 5, 'Baz'
  end
end
