require './fizzlang'

module Examples
    # An extended version of Fizz Buzz that adds a third
    # value, Bang
    # * +Fizz+ is 3
    # * +Buzz+ is 5
    # * +Bang+ is 7
    class FizzBuzzBang
        include FizzLang

        test_cases :Fizz, :Buzz, :Bang

        Fizz 3
        Buzz 5
        Bang 7
    end
end