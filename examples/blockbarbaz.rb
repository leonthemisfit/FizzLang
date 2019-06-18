require './lib/fizzlang'

module Examples
    # Example class used to demonstrate using the block form of the original
    # test_cases method with the new replacement strings added in
    class BlockBarBaz
        include FizzLang

        test_cases do |cases|
            cases[:bar] = [3, 'Bar']
            cases[:baz] = [5, 'Baz']
        end
    end
end