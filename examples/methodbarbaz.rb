require './lib/fizzlang'

module Examples
    # Example class used to demonstrate using all of the different class methods
    # available to set the values and strings associated with them
    class MethodBarBaz
        include FizzLang

        test_cases :bar, :baz

        bar 3
        baz 5

        bar_string 'Bar'
        baz_string 'Baz'
    end
end