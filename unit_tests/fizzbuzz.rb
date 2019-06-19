# frozen_string_literal: true

require './examples/fizzbuzz'

# Module containing all of the unit tests for the example classes
module UnitTests
  # Test Case for the Examples::FizzBuzz class
  class TestFizzBuzz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
      @fb = Examples::FizzBuzz.new(1..15)
    end

    # Test the class methods on FizzBuzz
    def test_static
      assert_equal('1', Examples::FizzBuzz.check(1))
      assert_equal('Fizz', Examples::FizzBuzz.check(3))
      assert_equal('Buzz', Examples::FizzBuzz.check(5))
      assert_equal('FizzBuzz', Examples::FizzBuzz.check(15))
      assert_equal(3, Examples::FizzBuzz.Fizz)
      assert_equal(5, Examples::FizzBuzz.Buzz)
      assert_equal(%w[1 2 Fizz], Examples::FizzBuzz.check_range(1..3))
    end

    # Test the basic instance usage and indexing on FizzBuzz
    def test_instance_basic
      assert_equal('1', @fb[0])
      assert_equal('Fizz', @fb[2])
      assert_equal('Buzz', @fb[4])
      assert_equal('FizzBuzz', @fb[14])
      assert_equal(nil, @fb[15])
      assert_equal(
        %w[1 2 Fizz 4 Buzz
           Fizz 7 8 Fizz Buzz
           11 Fizz 13 14 FizzBuzz], @fb.results
      )
      assert_equal(3, @fb.Fizz)
      assert_equal(5, @fb.Buzz)
    end

    # Test the results of calling +map+ on FizzBuzz
    def test_map
      up = @fb.map(&:upcase)

      assert_equal('1', up[0])
      assert_equal('FIZZ', up[2])
      assert_equal('BUZZ', up[4])
      assert_equal('FIZZBUZZ', up[14])
      assert_equal(nil, up[15])
    end

    # Test the +with_val+ method by calling it and mapping the
    # result for easier testing on FizzBuzz
    def test_with_val
      with_map = @fb.with_val.map do |val, res|
        "#{val}: #{res}"
      end

      assert_equal('1: 1', with_map[0])
      assert_equal('3: Fizz', with_map[2])
      assert_equal('5: Buzz', with_map[4])
      assert_equal('15: FizzBuzz', with_map[14])
      assert_equal(nil, with_map[15])
    end

    # Test the +select+ method for basic simple selections on FizzBuzz
    def test_select
      assert_equal(%w[Fizz Fizz Fizz Fizz], @fb.select { |res| res == 'Fizz' })
      assert_equal(%w[Buzz Buzz], @fb.select { |res| res == 'Buzz' })
      assert_equal(['FizzBuzz'], @fb.select { |res| res == 'FizzBuzz' })
    end

    # Test the +reject+ method for basic simple rejections on FizzBuzz
    def test_reject
      assert_equal(%w[1 2 4 7 8 11 13 14],
                   @fb.reject { |res| res.include?('Fizz') || res.include?('Buzz') })
    end

    # Test the join method on FizzBuzz
    def test_join
      assert_equal('1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz', @fb.join)
    end

    # Test the reduce method on FizzBuzz
    def test_reduce
      assert_equal('12Fizz4BuzzFizz78FizzBuzz11Fizz1314FizzBuzz',
                   @fb.reduce { |acc, res| acc + res })
    end
  end
end
