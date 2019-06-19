# frozen_string_literal: true

require './examples/stringybuzz'

module UnitTests
  # Test case for the Examples::StringyBuzz class
  class TestStringyBuzz < Test::Unit::TestCase
    # Test the resetting and reassignment of a string
    def test_manipulation
      assert_equal('1', Examples::StringyBuzz.check(1))
      assert_equal('Fizz', Examples::StringyBuzz.check(3))
      assert_equal('Buzz', Examples::StringyBuzz.check(5))
      assert_equal('Fuzz', Examples::StringyBuzz.check(6))
      assert_equal('FizzBuzz', Examples::StringyBuzz.check(15))
      assert_equal('FuzzBuzz', Examples::StringyBuzz.check(30))
      assert_equal('Fizz', Examples::StringyBuzz.fizz_string)

      Examples::StringyBuzz.fizz_string = 'Fozz'

      assert_equal('Fozz', Examples::StringyBuzz.check(3))
      assert_equal('Fuzz', Examples::StringyBuzz.check(6))
      assert_equal('Fozz', Examples::StringyBuzz.fizz_string)

      Examples::StringyBuzz.fizz_string :reset

      assert_equal('fizz', Examples::StringyBuzz.check(3))
      assert_equal('fizz', Examples::StringyBuzz.check(6))
      assert_equal('fizz', Examples::StringyBuzz.fizz_string)

      Examples::StringyBuzz.fizz_string = 'Fizz'

      assert_equal('Fizz', Examples::StringyBuzz.check(3))
      assert_equal('Fizz', Examples::StringyBuzz.check(6))
      assert_equal('Fizz', Examples::StringyBuzz.fizz_string)

      Examples::StringyBuzz.fizz_string { |val| 'Fuzz' if val.even? }

      assert_equal('1', Examples::StringyBuzz.check(1))
      assert_equal('Fizz', Examples::StringyBuzz.check(3))
      assert_equal('Buzz', Examples::StringyBuzz.check(5))
      assert_equal('Fuzz', Examples::StringyBuzz.check(6))
      assert_equal('FizzBuzz', Examples::StringyBuzz.check(15))
      assert_equal('FuzzBuzz', Examples::StringyBuzz.check(30))
      assert_equal('Fizz', Examples::StringyBuzz.fizz_string)
    end
  end
end
