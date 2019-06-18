require './lib/fizzlang'

module Examples
    # Example class used to demonstrate using the block form of getting string
    # replacement values, which allows for conditional replacement
    class BlockFizzBuzz
        include FizzLang

        test_cases fizz: [3, 'Fizz'], buzz: [5, 'Buzz']

        fizz_string { |val| 'Fuzz' if val.even? }
    end
end