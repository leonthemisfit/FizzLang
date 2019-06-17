require './examples/fizzbuzzfoobarbazbang'

module UnitTests
    # Test case for the Examples::FizzBuzzFooBarBazBang class
    class TestFizzBuzzFooBarBazBang < Test::Unit::TestCase
        # Test the static methods for case numbers on FizzBuzzFooBarBazBang class
        def test_static_case
            assert_equal('Fizz', Examples::FizzBuzzFooBarBazBang.check(3))
            assert_equal('Buzz', Examples::FizzBuzzFooBarBazBang.check(5))
            assert_equal('Foo', Examples::FizzBuzzFooBarBazBang.check(7))
            assert_equal('FizzBar', Examples::FizzBuzzFooBarBazBang.check(9))
            assert_equal('Baz', Examples::FizzBuzzFooBarBazBang.check(11))
            assert_equal('Bang', Examples::FizzBuzzFooBarBazBang.check(13))
        end

        # Test the static methods for least common multiples
        # of Fizz on FizzBuzzFooBarBazBang class
        def test_static_fizz
            assert_equal('FizzBuzz', Examples::FizzBuzzFooBarBazBang.check(15))
            assert_equal('FizzFoo', Examples::FizzBuzzFooBarBazBang.check(21))
            assert_equal('FizzBaz', Examples::FizzBuzzFooBarBazBang.check(33))
            assert_equal('FizzBang', Examples::FizzBuzzFooBarBazBang.check(39))
        end

        # Test the static methods for least common multiples
        # of Buzz on FizzBuzzFooBarBazBang class
        def test_static_buzz
            assert_equal('BuzzFoo', Examples::FizzBuzzFooBarBazBang.check(35))
            assert_equal('FizzBuzzBar', Examples::FizzBuzzFooBarBazBang.check(45))
            assert_equal('BuzzBaz', Examples::FizzBuzzFooBarBazBang.check(55))
            assert_equal('BuzzBang', Examples::FizzBuzzFooBarBazBang.check(65))
        end

        # Test the static methods for least common multiples
        # of Foo on FizzBuzzFooBarBazBang class
        def test_static_foo
            assert_equal('FizzFooBar', Examples::FizzBuzzFooBarBazBang.check(63))
            assert_equal('FooBaz', Examples::FizzBuzzFooBarBazBang.check(77))
            assert_equal('FooBang', Examples::FizzBuzzFooBarBazBang.check(91))
        end

        # Test the static methods for least common multiples
        # of Bar on FizzBuzzFooBarBazBang class
        def test_static_bar
            assert_equal('FizzBarBaz', Examples::FizzBuzzFooBarBazBang.check(99))
            assert_equal('FizzBarBang', Examples::FizzBuzzFooBarBazBang.check(117))
        end

        # Test the static methods for least common multiples
        # of Baz on FizzBuzzFooBarBazBang class
        def test_static_baz
            assert_equal('BazBang', Examples::FizzBuzzFooBarBazBang.check(143))
        end

        # Test large numbers on the FizzBuzzFooBarBazBang class
        def test_static_large
            assert_equal('FizzBuzzFooBarBazBang', Examples::FizzBuzzFooBarBazBang.check(45045))
            assert_equal('FizzBuzzFooBar', Examples::FizzBuzzFooBarBazBang.check(315))
            assert_equal('FizzFooBarBazBang', Examples::FizzBuzzFooBarBazBang.check(9009))
        end
    end
end