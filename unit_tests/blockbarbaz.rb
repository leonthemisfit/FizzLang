# frozen_string_literal: true

require './examples/blockbarbaz'

module UnitTests
  # Test Case for the Examples::BlockBarBaz class
  class TestBlockBarBaz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
      @bbb = Examples::BlockBarBaz.new(1..15)
    end

    # Test the class methods on BlockBarBaz
    def test_static
      assert_equal('1', Examples::BlockBarBaz.check(1))
      assert_equal('Bar', Examples::BlockBarBaz.check(3))
      assert_equal('Baz', Examples::BlockBarBaz.check(5))
      assert_equal('BarBaz', Examples::BlockBarBaz.check(15))
      assert_equal(3, Examples::BlockBarBaz.bar)
      assert_equal(5, Examples::BlockBarBaz.baz)
      assert_equal(%w[1 2 Bar], Examples::BlockBarBaz.check_range(1..3))

      assert_equal('Bar', Examples::BlockBarBaz.bar_string)
      assert_equal('Baz', Examples::BlockBarBaz.baz_string)
    end

    # Test the basic instance usage and indexing on BlockBarBaz
    def test_instance_basic
      assert_equal('1', @bbb[0])
      assert_equal('Bar', @bbb[2])
      assert_equal('Baz', @bbb[4])
      assert_equal('BarBaz', @bbb[14])
      assert_equal(nil, @bbb[15])
      assert_equal(
        %w[1 2 Bar 4 Baz
           Bar 7 8 Bar Baz
           11 Bar 13 14 BarBaz], @bbb.results
      )
      assert_equal(3, @bbb.bar)
      assert_equal(5, @bbb.baz)

      assert_equal('Bar', @bbb.bar_string)
      assert_equal('Baz', @bbb.baz_string)
    end

    # Test the results of calling +map+ on BlockBarBaz
    def test_map
      up = @bbb.map(&:upcase)

      assert_equal('1', up[0])
      assert_equal('BAR', up[2])
      assert_equal('BAZ', up[4])
      assert_equal('BARBAZ', up[14])
      assert_equal(nil, up[15])
    end

    # Test the +with_val+ method by calling it and mapping the
    # result for easier testing on BlockBarBaz
    def test_with_val
      with_map = @bbb.with_val.map do |val, res|
        "#{val}: #{res}"
      end

      assert_equal('1: 1', with_map[0])
      assert_equal('3: Bar', with_map[2])
      assert_equal('5: Baz', with_map[4])
      assert_equal('15: BarBaz', with_map[14])
      assert_equal(nil, with_map[15])
    end

    # Test the +select+ method for basic simple selections on BlockBarBaz
    def test_select
      assert_equal(%w[Bar Bar Bar Bar], @bbb.select { |res| res == 'Bar' })
      assert_equal(%w[Baz Baz], @bbb.select { |res| res == 'Baz' })
      assert_equal(['BarBaz'], @bbb.select { |res| res == 'BarBaz' })
    end

    # Test the +reject+ method for basic simple rejections on BlockBarBaz
    def test_reject
      assert_equal(%w[1 2 4 7 8 11 13 14],
                   @bbb.reject { |res| res.include?('Bar') || res.include?('Baz') })
    end

    # Test the join method on BlockBarBaz
    def test_join
      assert_equal('1 2 Bar 4 Baz Bar 7 8 Bar Baz 11 Bar 13 14 BarBaz', @bbb.join)
    end

    # Test the reduce method on BlockBarBaz
    def test_reduce
      assert_equal('12Bar4BazBar78BarBaz11Bar1314BarBaz',
                   @bbb.reduce { |acc, res| acc + res })
    end
  end
end
