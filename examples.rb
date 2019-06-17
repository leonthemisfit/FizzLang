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

# A class used to demonstrate the use of the assignment method of
# setting up and manipulating a class
class AssignBuzz
    include FizzLang

    test_cases :Assign, :Buzz

    Assign 10
    Buzz 5
end
#:stopdoc:
AssignBuzz.Assign = 3
#:startdoc:

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

# Example class used to demonstrate using the shortened form of the original
# class methods used to setup the class
class ShorterBarBaz
    include FizzLang

    test_cases :bar, :baz

    bar 3, 'Bar'
    baz 5, 'Baz'
end

# Example class used to demonstrate using the shortened keyword form of the
# original test_cases method
class KeywordBarBaz
    include FizzLang

    test_cases bar: [3, 'Bar'], baz: [5, 'Baz']
end

# Example class used to demonstrate using the block form of the original
# test_cases method with the new replacement strings added in
class BlockBarBaz
    include FizzLang

    test_cases do |cases|
        cases[:bar] = [3, 'Bar']
        cases[:baz] = [5, 'Baz']
    end
end

# Example class used to demonstrate using the block form of getting string
# replacement values, which allows for conditional replacement
class BlockFizzBuzz
    include FizzLang

    test_cases fizz: [3, 'Fizz'], buzz: [5, 'Buzz']

    fizz_string { |val| 'Fuzz' if val.even? }
end

# Example class used to demonstrate using many test cases
class FizzBuzzFooBarBazBang
    include FizzLang

    test_cases :fizz, :buzz, :foo, :bar, :baz, :bang

    fizz 3, 'Fizz'
    buzz 5, 'Buzz'
    foo 7, 'Foo'
    bar 9, 'Bar'
    baz 11, 'Baz'
    bang 13, 'Bang'
end

# Example class used to demonstrate setting both the string value
# and the string function with a single call to the string method
class StringyBuzz
    include FizzLang

    test_cases fizz: 3, buzz: [5, 'Buzz']

    fizz_string 'Fizz' do |val| 
        'Fuzz' if val.even?
    end
end