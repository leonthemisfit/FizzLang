require './fizzlang'

module Examples
    # Example class used to demonstrate using the shortened keyword form of the
    # original test_cases method
    class KeywordBarBaz
        include FizzLang

        test_cases bar: [3, 'Bar'], baz: [5, 'Baz']
    end
end