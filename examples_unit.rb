require 'test/unit'
require './examples'

class TestFizzBuzz < Test::Unit::TestCase
    def test_static
        assert_equal('1', FizzBuzz.check(1))
        assert_equal('Fizz', FizzBuzz.check(3))
        assert_equal('Buzz', FizzBuzz.check(5))
        assert_equal('FizzBuzz', FizzBuzz.check(15))
    end

    def test_instance_basic
        assert_equal('1', FizzBuzz.new(1..10)[0])
        assert_equal('Fizz', FizzBuzz.new(1..10)[2])
        assert_equal('Buzz', FizzBuzz.new(1..10)[4])
        assert_equal('FizzBuzz', FizzBuzz.new(1..15)[14])
    end
end