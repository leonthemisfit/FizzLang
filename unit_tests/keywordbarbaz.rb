require './examples/keywordbarbaz'

module UnitTests
    # Test Case for the Examples::KeywordBarBaz class
    class TestKeywordBarBaz < Test::Unit::TestCase
        # Prepare +fb+ instance variable for use in tests
        def setup
            @kbb = Examples::KeywordBarBaz.new(1..15)
        end

        # Test the class methods on KeywordBarBaz
        def test_static
            assert_equal('1', Examples::KeywordBarBaz.check(1))
            assert_equal('Bar', Examples::KeywordBarBaz.check(3))
            assert_equal('Baz', Examples::KeywordBarBaz.check(5))
            assert_equal('BarBaz', Examples::KeywordBarBaz.check(15))
            assert_equal(3, Examples::KeywordBarBaz.bar)
            assert_equal(5, Examples::KeywordBarBaz.baz)
            assert_equal(['1', '2', 'Bar'], Examples::KeywordBarBaz.check_range(1..3))

            assert_equal('Bar', Examples::KeywordBarBaz.bar_string)
            assert_equal('Baz', Examples::KeywordBarBaz.baz_string)
        end

        # Test the basic instance usage and indexing on KeywordBarBaz
        def test_instance_basic
            assert_equal('1', @kbb[0])
            assert_equal('Bar', @kbb[2])
            assert_equal('Baz', @kbb[4])
            assert_equal('BarBaz', @kbb[14])
            assert_equal(nil, @kbb[15])
            assert_equal(
                ['1', '2', 'Bar', '4', 'Baz', 
                'Bar', '7', '8', 'Bar', 'Baz', 
                '11', 'Bar', '13', '14', 'BarBaz'], @kbb.results)
            assert_equal(3, @kbb.bar)
            assert_equal(5, @kbb.baz)
        end

        # Test the results of calling +map+ on KeywordBarBaz
        def test_map
            up = @kbb.map { |res| res.upcase }

            assert_equal('1', up[0])
            assert_equal('BAR', up[2])
            assert_equal('BAZ', up[4])
            assert_equal('BARBAZ', up[14])
            assert_equal(nil, up[15])
        end

        # Test the +with_val+ method by calling it and mapping the
        # result for easier testing on KeywordBarBaz
        def test_with_val
            with_map = @kbb.with_val.map do |val, res|
                "#{val}: #{res}"
            end

            assert_equal('1: 1', with_map[0])
            assert_equal('3: Bar', with_map[2])
            assert_equal('5: Baz', with_map[4])
            assert_equal('15: BarBaz', with_map[14])
            assert_equal(nil, with_map[15])
        end

        # Test the +select+ method for basic simple selections on KeywordBarBaz
        def test_select
            assert_equal(['Bar', 'Bar', 'Bar', 'Bar'], @kbb.select { |res| res == 'Bar' })
            assert_equal(['Baz', 'Baz'], @kbb.select { |res| res == 'Baz' })
            assert_equal(['BarBaz'], @kbb.select { |res| res == 'BarBaz' })
        end

        # Test the +reject+ method for basic simple rejections on KeywordBarBaz
        def test_reject
            assert_equal(['1', '2', '4', '7', '8', '11', '13', '14'], 
                @kbb.reject { |res| res.include?('Bar') || res.include?('Baz') })
        end

        # Test the join method on KeywordBarBaz
        def test_join
            assert_equal('1 2 Bar 4 Baz Bar 7 8 Bar Baz 11 Bar 13 14 BarBaz', @kbb.join)
        end

        # Test the reduce method on KeywordBarBaz
        def test_reduce
            assert_equal('12Bar4BazBar78BarBaz11Bar1314BarBaz', 
                @kbb.reduce { |acc, res| acc + res })
        end
    end
end