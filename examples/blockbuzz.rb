require './fizzlang'

module Examples
    # A class used to demonstrate the use of a block to setup the
    # class in place of using the class methods directly
    class BlockBuzz
        include FizzLang

        test_cases do |cases|
            cases[:Block] = 3
            cases[:Buzz] = 5
        end
    end
end