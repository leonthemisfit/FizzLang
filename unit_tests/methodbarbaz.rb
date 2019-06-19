# frozen_string_literal: true

require './examples/methodbarbaz'

module UnitTests
  # Test Case for the Examples::MethodBarBaz class
  class TestMethodBarBaz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
      @mbb = Examples::MethodBarBaz.new(1..15)
    end

    # Test the class methods on MethodBarBaz
    def test_static
      assert_equal('1', Examples::MethodBarBaz.check(1))
      assert_equal('Bar', Examples::MethodBarBaz.check(3))
      assert_equal('Baz', Examples::MethodBarBaz.check(5))
      assert_equal('BarBaz', Examples::MethodBarBaz.check(15))
      assert_equal(3, Examples::MethodBarBaz.bar)
      assert_equal(5, Examples::MethodBarBaz.baz)
      assert_equal(%w[1 2 Bar], Examples::MethodBarBaz.check_range(1..3))

      assert_equal('Bar', Examples::MethodBarBaz.bar_string)
      assert_equal('Baz', Examples::MethodBarBaz.baz_string)
    end

    # Test the basic instance usage and indexing on MethodBarBaz
    def test_instance_basic
      assert_equal('1', @mbb[0])
      assert_equal('Bar', @mbb[2])
      assert_equal('Baz', @mbb[4])
      assert_equal('BarBaz', @mbb[14])
      assert_equal(nil, @mbb[15])
      assert_equal(
        %w[1 2 Bar 4 Baz
           Bar 7 8 Bar Baz
           11 Bar 13 14 BarBaz], @mbb.results
      )
      assert_equal(3, @mbb.bar)
      assert_equal(5, @mbb.baz)
    end

    # Test the results of calling +map+ on MethodBarBaz
    def test_map
      up = @mbb.map(&:upcase)

      assert_equal('1', up[0])
      assert_equal('BAR', up[2])
      assert_equal('BAZ', up[4])
      assert_equal('BARBAZ', up[14])
      assert_equal(nil, up[15])
    end

    # Test the +with_val+ method by calling it and mapping the
    # result for easier testing on MethodBarBaz
    def test_with_val
      with_map = @mbb.with_val.map do |val, res|
        "#{val}: #{res}"
      end

      assert_equal('1: 1', with_map[0])
      assert_equal('3: Bar', with_map[2])
      assert_equal('5: Baz', with_map[4])
      assert_equal('15: BarBaz', with_map[14])
      assert_equal(nil, with_map[15])
    end

    # Test the +select+ method for basic simple selections on MethodBarBaz
    def test_select
      assert_equal(%w[Bar Bar Bar Bar], @mbb.select { |res| res == 'Bar' })
      assert_equal(%w[Baz Baz], @mbb.select { |res| res == 'Baz' })
      assert_equal(['BarBaz'], @mbb.select { |res| res == 'BarBaz' })
    end

    # Test the +reject+ method for basic simple rejections on MethodBarBaz
    def test_reject
      assert_equal(%w[1 2 4 7 8 11 13 14],
                   @mbb.reject { |res| res.include?('Bar') || res.include?('Baz') })
    end

    # Test the join method on MethodBarBaz
    def test_join
      assert_equal('1 2 Bar 4 Baz Bar 7 8 Bar Baz 11 Bar 13 14 BarBaz', @mbb.join)
    end

    # Test the reduce method on MethodBarBaz
    def test_reduce
      assert_equal('12Bar4BazBar78BarBaz11Bar1314BarBaz',
                   @mbb.reduce { |acc, res| acc + res })
    end
  end
end
