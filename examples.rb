require './fizzlang'

# The classic Fizz Buzz
# * +Fizz+ is 3
# * +Buzz+ is 5
class FizzBuzz
    include FizzLang

    test_cases :Fizz, :Buzz

    Fizz 3
    Buzz 5
end

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

# A variation of Fizz Buzz replacing fizz and buzz with
# foo and bar respectively
# * +Foo+ is 5
# * +Bar+ is 10
class FooBar
    include FizzLang

    test_cases :Foo, :Bar

    Foo 5
    Bar 10
end