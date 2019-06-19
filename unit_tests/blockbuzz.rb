# frozen_string_literal: true

require './examples/blockbuzz'

module UnitTests
  # Test Case for the Examples::BlockBuzz class
  class TestBlockBuzz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
      @bb = Examples::BlockBuzz.new(1..15)
    end

    # Test the class methods on BlockBuzz
    def test_static
      assert_equal('1', Examples::BlockBuzz.check(1))
      assert_equal('Block', Examples::BlockBuzz.check(3))
      assert_equal('Buzz', Examples::BlockBuzz.check(5))
      assert_equal('BlockBuzz', Examples::BlockBuzz.check(15))
      assert_equal(3, Examples::BlockBuzz.Block)
      assert_equal(5, Examples::BlockBuzz.Buzz)
      assert_equal(%w[1 2 Block], Examples::BlockBuzz.check_range(1..3))
    end

    # Test the basic instance usage and indexing on BlockBuzz
    def test_instance_basic
      assert_equal('1', @bb[0])
      assert_equal('Block', @bb[2])
      assert_equal('Buzz', @bb[4])
      assert_equal('BlockBuzz', @bb[14])
      assert_equal(nil, @bb[15])
      assert_equal(
        %w[1 2 Block 4 Buzz
           Block 7 8 Block Buzz
           11 Block 13 14 BlockBuzz], @bb.results
      )
      assert_equal(3, @bb.Block)
      assert_equal(5, @bb.Buzz)
    end

    # Test the results of calling +map+ on BlockBuzz
    def test_map
      up = @bb.map(&:upcase)

      assert_equal('1', up[0])
      assert_equal('BLOCK', up[2])
      assert_equal('BUZZ', up[4])
      assert_equal('BLOCKBUZZ', up[14])
      assert_equal(nil, up[15])
    end

    # Test the +with_val+ method by calling it and mapping the
    # result for easier testing on BlockBuzz
    def test_with_val
      with_map = @bb.with_val.map do |val, res|
        "#{val}: #{res}"
      end

      assert_equal('1: 1', with_map[0])
      assert_equal('3: Block', with_map[2])
      assert_equal('5: Buzz', with_map[4])
      assert_equal('15: BlockBuzz', with_map[14])
      assert_equal(nil, with_map[15])
    end

    # Test the +select+ method for basic simple selections on BlockBuzz
    def test_select
      assert_equal(%w[Block Block Block Block], @bb.select { |res| res == 'Block' })
      assert_equal(%w[Buzz Buzz], @bb.select { |res| res == 'Buzz' })
      assert_equal(['BlockBuzz'], @bb.select { |res| res == 'BlockBuzz' })
    end

    # Test the +reject+ method for basic simple rejections on BlockBuzz
    def test_reject
      assert_equal(%w[1 2 4 7 8 11 13 14],
                   @bb.reject { |res| res.include?('Block') || res.include?('Buzz') })
    end

    # Test the join method on BlockBuzz
    def test_join
      assert_equal('1 2 Block 4 Buzz Block 7 8 Block Buzz 11 Block 13 14 BlockBuzz', @bb.join)
    end

    # Test the reduce method on BlockBuzz
    def test_reduce
      assert_equal('12Block4BuzzBlock78BlockBuzz11Block1314BlockBuzz',
                   @bb.reduce { |acc, res| acc + res })
    end
  end
end
