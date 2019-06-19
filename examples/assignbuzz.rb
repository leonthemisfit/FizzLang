# frozen_string_literal: true

require './lib/fizzlang'

module Examples
  # A class used to demonstrate the use of the assignment method of
  # setting up and manipulating a class
  class AssignBuzz
    include FizzLang

    test_cases :Assign, :Buzz

    Assign 10
    Buzz 5
  end
  #:stopdoc:
  AssignBuzz.Assign = 3
  #:startdoc:
end
