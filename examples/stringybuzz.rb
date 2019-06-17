require './fizzlang'

module Examples
    # Example class used to demonstrate setting both the string value
    # and the string function with a single call to the string method
    class StringyBuzz
        include FizzLang

        test_cases fizz: 3, buzz: [5, 'Buzz']

        fizz_string 'Fizz' do |val| 
            'Fuzz' if val.even?
        end
    end
end