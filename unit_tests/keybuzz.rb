# frozen_string_literal: true

require './examples/keybuzz'

module UnitTests
  # Test Case for the Examples::KeyBuzz class
  class TestKeyBuzz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
      @kb = Examples::KeyBuzz.new(1..15)
    end

    # Test the class methods on KeyBuzz
    def test_static
      assert_equal('1', Examples::KeyBuzz.check(1))
      assert_equal('Key', Examples::KeyBuzz.check(3))
      assert_equal('Buzz', Examples::KeyBuzz.check(5))
      assert_equal('KeyBuzz', Examples::KeyBuzz.check(15))
      assert_equal(3, Examples::KeyBuzz.Key)
      assert_equal(5, Examples::KeyBuzz.Buzz)
      assert_equal(%w[1 2 Key], Examples::KeyBuzz.check_range(1..3))
    end

    # Test the basic instance usage and indexing on KeyBuzz
    def test_instance_basic
      assert_equal('1', @kb[0])
      assert_equal('Key', @kb[2])
      assert_equal('Buzz', @kb[4])
      assert_equal('KeyBuzz', @kb[14])
      assert_equal(nil, @kb[15])
      assert_equal(
        %w[1 2 Key 4 Buzz
           Key 7 8 Key Buzz
           11 Key 13 14 KeyBuzz], @kb.results
      )
      assert_equal(3, @kb.Key)
      assert_equal(5, @kb.Buzz)
    end

    # Test the results of calling +map+ on KeyBuzz
    def test_map
      up = @kb.map(&:upcase)

      assert_equal('1', up[0])
      assert_equal('KEY', up[2])
      assert_equal('BUZZ', up[4])
      assert_equal('KEYBUZZ', up[14])
      assert_equal(nil, up[15])
    end

    # Test the +with_val+ method by calling it and mapping the
    # result for easier testing on KeyBuzz
    def test_with_val
      with_map = @kb.with_val.map do |val, res|
        "#{val}: #{res}"
      end

      assert_equal('1: 1', with_map[0])
      assert_equal('3: Key', with_map[2])
      assert_equal('5: Buzz', with_map[4])
      assert_equal('15: KeyBuzz', with_map[14])
      assert_equal(nil, with_map[15])
    end

    # Test the +select+ method for basic simple selections on KeyBuzz
    def test_select
      assert_equal(%w[Key Key Key Key], @kb.select { |res| res == 'Key' })
      assert_equal(%w[Buzz Buzz], @kb.select { |res| res == 'Buzz' })
      assert_equal(['KeyBuzz'], @kb.select { |res| res == 'KeyBuzz' })
    end

    # Test the +reject+ method for basic simple rejections on KeyBuzz
    def test_reject
      assert_equal(%w[1 2 4 7 8 11 13 14],
                   @kb.reject { |res| res.include?('Key') || res.include?('Buzz') })
    end

    # Test the join method on KeyBuzz
    def test_join
      assert_equal('1 2 Key 4 Buzz Key 7 8 Key Buzz 11 Key 13 14 KeyBuzz', @kb.join)
    end

    # Test the reduce method on KeyBuzz
    def test_reduce
      assert_equal('12Key4BuzzKey78KeyBuzz11Key1314KeyBuzz',
                   @kb.reduce { |acc, res| acc + res })
    end
  end
end
