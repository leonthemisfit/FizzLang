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

# A class used to demonstrate how class methods can be called
# outside the class declaration and provide the same result.
class Fizz
    include FizzLang
end
Fizz.test_cases(:Fizz)
Fizz.Fizz(3)

# A class used to demonstrate the use of a block to setup the
# class in place of using the class methods directly
class BlockBuzz
    include FizzLang

    test_cases do |cases|
        cases[:Block] = 3
        cases[:Buzz] = 5
    end
end

# A class used to demonstrate a use of keyword arguments to
# setup the class in place of class methods and blocks
class KeyBuzz
    include FizzLang

    test_cases Key: 3, Buzz: 5
end