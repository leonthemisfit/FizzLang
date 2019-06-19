# frozen_string_literal: true

require './examples/blockfizzbuzz'

module UnitTests
  # Test case for the Examples::BlockFizzBuzz class
  class TestBlockFizzBuzz < Test::Unit::TestCase
    # Test the resetting and reassignment of a string
    def test_manipulation
      assert_equal('1', Examples::BlockFizzBuzz.check(1))
      assert_equal('Fizz', Examples::BlockFizzBuzz.check(3))
      assert_equal('Buzz', Examples::BlockFizzBuzz.check(5))
      assert_equal('Fuzz', Examples::BlockFizzBuzz.check(6))
      assert_equal('FizzBuzz', Examples::BlockFizzBuzz.check(15))
      assert_equal('FuzzBuzz', Examples::BlockFizzBuzz.check(30))
      assert_equal('Fizz', Examples::BlockFizzBuzz.fizz_string)

      Examples::BlockFizzBuzz.fizz_string = 'Fozz'

      assert_equal('Fozz', Examples::BlockFizzBuzz.check(3))
      assert_equal('Fuzz', Examples::BlockFizzBuzz.check(6))
      assert_equal('Fozz', Examples::BlockFizzBuzz.fizz_string)

      Examples::BlockFizzBuzz.fizz_string :reset

      assert_equal('fizz', Examples::BlockFizzBuzz.check(3))
      assert_equal('fizz', Examples::BlockFizzBuzz.check(6))
      assert_equal('fizz', Examples::BlockFizzBuzz.fizz_string)

      Examples::BlockFizzBuzz.fizz_string = 'Fizz'

      assert_equal('Fizz', Examples::BlockFizzBuzz.check(3))
      assert_equal('Fizz', Examples::BlockFizzBuzz.check(6))
      assert_equal('Fizz', Examples::BlockFizzBuzz.fizz_string)

      Examples::BlockFizzBuzz.fizz_string { |val| 'Fuzz' if val.even? }

      assert_equal('1', Examples::BlockFizzBuzz.check(1))
      assert_equal('Fizz', Examples::BlockFizzBuzz.check(3))
      assert_equal('Buzz', Examples::BlockFizzBuzz.check(5))
      assert_equal('Fuzz', Examples::BlockFizzBuzz.check(6))
      assert_equal('FizzBuzz', Examples::BlockFizzBuzz.check(15))
      assert_equal('FuzzBuzz', Examples::BlockFizzBuzz.check(30))
      assert_equal('Fizz', Examples::BlockFizzBuzz.fizz_string)
    end
  end
end
