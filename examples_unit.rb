require 'test/unit'
require './examples'

class TestFizzBuzz < Test::Unit::TestCase
    def setup
        @fb = FizzBuzz.new(1..15)
    end

    def test_static
        assert_equal('1', FizzBuzz.check(1))
        assert_equal('Fizz', FizzBuzz.check(3))
        assert_equal('Buzz', FizzBuzz.check(5))
        assert_equal('FizzBuzz', FizzBuzz.check(15))
    end

    def test_instance_basic
        assert_equal('1', @fb[0])
        assert_equal('Fizz', @fb[2])
        assert_equal('Buzz', @fb[4])
        assert_equal('FizzBuzz', @fb[14])
        assert_equal(nil, @fb[15])
    end

    def test_map
        up = @fb.map { |res| res.upcase }

        assert_equal('1', up[0])
        assert_equal('FIZZ', up[2])
        assert_equal('BUZZ', up[4])
        assert_equal('FIZZBUZZ', up[14])
        assert_equal(nil, up[15])
    end
end