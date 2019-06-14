require './fizzlang'

class FizzBuzz
    include FizzLang

    test_cases :Fizz, :Buzz

    Fizz 3
    Buzz 5
end

class FizzBuzzBang
    include FizzLang

    test_cases :Fizz, :Buzz, :Bang

    Fizz 3
    Buzz 5
    Bang 7
end

class FooBar
    include FizzLang

    test_cases :Foo, :Bar

    Foo 5
    Bar 10
end