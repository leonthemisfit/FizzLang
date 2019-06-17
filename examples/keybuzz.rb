require './fizzlang'

module Examples
    # A class used to demonstrate a use of keyword arguments to
    # setup the class in place of class methods and blocks
    class KeyBuzz
        include FizzLang

        test_cases Key: 3, Buzz: 5
    end
end