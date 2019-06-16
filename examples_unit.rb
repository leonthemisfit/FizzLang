require 'test/unit'
require './examples'

# Test Case for the FizzBuzz class
class TestFizzBuzz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
        @fb = FizzBuzz.new(1..15)
    end

    # Test the class methods on FizzBuzz
    def test_static
        assert_equal('1', FizzBuzz.check(1))
        assert_equal('Fizz', FizzBuzz.check(3))
        assert_equal('Buzz', FizzBuzz.check(5))
        assert_equal('FizzBuzz', FizzBuzz.check(15))
        assert_equal(3, FizzBuzz.Fizz)
        assert_equal(5, FizzBuzz.Buzz)
        assert_equal(['1', '2', 'Fizz'], FizzBuzz.check_range(1..3))
    end

    # Test the basic instance usage and indexing on FizzBuzz
    def test_instance_basic
        assert_equal('1', @fb[0])
        assert_equal('Fizz', @fb[2])
        assert_equal('Buzz', @fb[4])
        assert_equal('FizzBuzz', @fb[14])
        assert_equal(nil, @fb[15])
        assert_equal(
            ['1', '2', 'Fizz', '4', 'Buzz', 
            'Fizz', '7', '8', 'Fizz', 'Buzz', 
            '11', 'Fizz', '13', '14', 'FizzBuzz'], @fb.results)
        assert_equal(3, @fb.Fizz)
        assert_equal(5, @fb.Buzz)
    end

    # Test the results of calling +map+ on FizzBuzz
    def test_map
        up = @fb.map { |res| res.upcase }

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
        assert_equal(['Fizz', 'Fizz', 'Fizz', 'Fizz'], @fb.select { |res| res == 'Fizz' })
        assert_equal(['Buzz', 'Buzz'], @fb.select { |res| res == 'Buzz' })
        assert_equal(['FizzBuzz'], @fb.select { |res| res == 'FizzBuzz' })
    end

    # Test the +reject+ method for basic simple rejections on FizzBuzz
    def test_reject
        assert_equal(['1', '2', '4', '7', '8', '11', '13', '14'], 
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

# Test Case for the BlockBuzz class
class TestBlockBuzz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
        @bb = BlockBuzz.new(1..15)
    end

    # Test the class methods on BlockBuzz
    def test_static
        assert_equal('1', BlockBuzz.check(1))
        assert_equal('Block', BlockBuzz.check(3))
        assert_equal('Buzz', BlockBuzz.check(5))
        assert_equal('BlockBuzz', BlockBuzz.check(15))
        assert_equal(3, BlockBuzz.Block)
        assert_equal(5, BlockBuzz.Buzz)
        assert_equal(['1', '2', 'Block'], BlockBuzz.check_range(1..3))
    end

    # Test the basic instance usage and indexing on BlockBuzz
    def test_instance_basic
        assert_equal('1', @bb[0])
        assert_equal('Block', @bb[2])
        assert_equal('Buzz', @bb[4])
        assert_equal('BlockBuzz', @bb[14])
        assert_equal(nil, @bb[15])
        assert_equal(
            ['1', '2', 'Block', '4', 'Buzz', 
            'Block', '7', '8', 'Block', 'Buzz', 
            '11', 'Block', '13', '14', 'BlockBuzz'], @bb.results)
        assert_equal(3, @bb.Block)
        assert_equal(5, @bb.Buzz)
    end

    # Test the results of calling +map+ on BlockBuzz
    def test_map
        up = @bb.map { |res| res.upcase }

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
        assert_equal(['Block', 'Block', 'Block', 'Block'], @bb.select { |res| res == 'Block' })
        assert_equal(['Buzz', 'Buzz'], @bb.select { |res| res == 'Buzz' })
        assert_equal(['BlockBuzz'], @bb.select { |res| res == 'BlockBuzz' })
    end

    # Test the +reject+ method for basic simple rejections on BlockBuzz
    def test_reject
        assert_equal(['1', '2', '4', '7', '8', '11', '13', '14'], 
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

# Test Case for the KeyBuzz class
class TestKeyBuzz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
        @kb = KeyBuzz.new(1..15)
    end

    # Test the class methods on KeyBuzz
    def test_static
        assert_equal('1', KeyBuzz.check(1))
        assert_equal('Key', KeyBuzz.check(3))
        assert_equal('Buzz', KeyBuzz.check(5))
        assert_equal('KeyBuzz', KeyBuzz.check(15))
        assert_equal(3, KeyBuzz.Key)
        assert_equal(5, KeyBuzz.Buzz)
        assert_equal(['1', '2', 'Key'], KeyBuzz.check_range(1..3))
    end

    # Test the basic instance usage and indexing on KeyBuzz
    def test_instance_basic
        assert_equal('1', @kb[0])
        assert_equal('Key', @kb[2])
        assert_equal('Buzz', @kb[4])
        assert_equal('KeyBuzz', @kb[14])
        assert_equal(nil, @kb[15])
        assert_equal(
            ['1', '2', 'Key', '4', 'Buzz', 
            'Key', '7', '8', 'Key', 'Buzz', 
            '11', 'Key', '13', '14', 'KeyBuzz'], @kb.results)
        assert_equal(3, @kb.Key)
        assert_equal(5, @kb.Buzz)
    end

    # Test the results of calling +map+ on KeyBuzz
    def test_map
        up = @kb.map { |res| res.upcase }

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
        assert_equal(['Key', 'Key', 'Key', 'Key'], @kb.select { |res| res == 'Key' })
        assert_equal(['Buzz', 'Buzz'], @kb.select { |res| res == 'Buzz' })
        assert_equal(['KeyBuzz'], @kb.select { |res| res == 'KeyBuzz' })
    end

    # Test the +reject+ method for basic simple rejections on KeyBuzz
    def test_reject
        assert_equal(['1', '2', '4', '7', '8', '11', '13', '14'], 
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

# Test Case for the AssignBuzz class
class TestAssignBuzz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
        @ab = AssignBuzz.new(1..15)
    end

    # Test the class methods on AssignBuzz
    def test_static
        assert_equal('1', AssignBuzz.check(1))
        assert_equal('Assign', AssignBuzz.check(3))
        assert_equal('Buzz', AssignBuzz.check(5))
        assert_equal('AssignBuzz', AssignBuzz.check(15))
        assert_equal(3, AssignBuzz.Assign)
        assert_equal(5, AssignBuzz.Buzz)
        assert_equal(['1', '2', 'Assign'], AssignBuzz.check_range(1..3))
    end

    # Test the basic instance usage and indexing on AssignBuzz
    def test_instance_basic
        assert_equal('1', @ab[0])
        assert_equal('Assign', @ab[2])
        assert_equal('Buzz', @ab[4])
        assert_equal('AssignBuzz', @ab[14])
        assert_equal(nil, @ab[15])
        assert_equal(
            ['1', '2', 'Assign', '4', 'Buzz', 
            'Assign', '7', '8', 'Assign', 'Buzz', 
            '11', 'Assign', '13', '14', 'AssignBuzz'], @ab.results)
        assert_equal(3, @ab.Assign)
        assert_equal(5, @ab.Buzz)
    end

    # Test the results of calling +map+ on AssignBuzz
    def test_map
        up = @ab.map { |res| res.upcase }

        assert_equal('1', up[0])
        assert_equal('ASSIGN', up[2])
        assert_equal('BUZZ', up[4])
        assert_equal('ASSIGNBUZZ', up[14])
        assert_equal(nil, up[15])
    end

    # Test the +with_val+ method by calling it and mapping the
    # result for easier testing on AssignBuzz
    def test_with_val
        with_map = @ab.with_val.map do |val, res|
            "#{val}: #{res}"
        end

        assert_equal('1: 1', with_map[0])
        assert_equal('3: Assign', with_map[2])
        assert_equal('5: Buzz', with_map[4])
        assert_equal('15: AssignBuzz', with_map[14])
        assert_equal(nil, with_map[15])
    end

    # Test the +select+ method for basic simple selections on AssignBuzz
    def test_select
        assert_equal(['Assign', 'Assign', 'Assign', 'Assign'], @ab.select { |res| res == 'Assign' })
        assert_equal(['Buzz', 'Buzz'], @ab.select { |res| res == 'Buzz' })
        assert_equal(['AssignBuzz'], @ab.select { |res| res == 'AssignBuzz' })
    end

    # Test the +reject+ method for basic simple rejections on AssignBuzz
    def test_reject
        assert_equal(['1', '2', '4', '7', '8', '11', '13', '14'], 
            @ab.reject { |res| res.include?('Assign') || res.include?('Buzz') })
    end

    # Test the join method on AssignBuzz
    def test_join
        assert_equal('1 2 Assign 4 Buzz Assign 7 8 Assign Buzz 11 Assign 13 14 AssignBuzz', @ab.join)
    end

    # Test the reduce method on AssignBuzz
    def test_reduce
        assert_equal('12Assign4BuzzAssign78AssignBuzz11Assign1314AssignBuzz', 
            @ab.reduce { |acc, res| acc + res })
    end
end

# Test Case for the MethodBarBaz class
class TestMethodBarBaz < Test::Unit::TestCase
    # Prepare +fb+ instance variable for use in tests
    def setup
        @mbb = MethodBarBaz.new(1..15)
    end

    # Test the class methods on MethodBarBaz
    def test_static
        assert_equal('1', MethodBarBaz.check(1))
        assert_equal('Bar', MethodBarBaz.check(3))
        assert_equal('Baz', MethodBarBaz.check(5))
        assert_equal('BarBaz', MethodBarBaz.check(15))
        assert_equal(3, MethodBarBaz.bar)
        assert_equal(5, MethodBarBaz.baz)
        assert_equal(['1', '2', 'Bar'], MethodBarBaz.check_range(1..3))

        assert_equal('Bar', MethodBarBaz.bar_string)
        assert_equal('Baz', MethodBarBaz.baz_string)
    end

    # Test the basic instance usage and indexing on MethodBarBaz
    def test_instance_basic
        assert_equal('1', @mbb[0])
        assert_equal('Bar', @mbb[2])
        assert_equal('Baz', @mbb[4])
        assert_equal('BarBaz', @mbb[14])
        assert_equal(nil, @mbb[15])
        assert_equal(
            ['1', '2', 'Bar', '4', 'Baz', 
            'Bar', '7', '8', 'Bar', 'Baz', 
            '11', 'Bar', '13', '14', 'BarBaz'], @mbb.results)
        assert_equal(3, @mbb.bar)
        assert_equal(5, @mbb.baz)
    end

    # Test the results of calling +map+ on MethodBarBaz
    def test_map
        up = @mbb.map { |res| res.upcase }

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
        assert_equal(['Bar', 'Bar', 'Bar', 'Bar'], @mbb.select { |res| res == 'Bar' })
        assert_equal(['Baz', 'Baz'], @mbb.select { |res| res == 'Baz' })
        assert_equal(['BarBaz'], @mbb.select { |res| res == 'BarBaz' })
    end

    # Test the +reject+ method for basic simple rejections on MethodBarBaz
    def test_reject
        assert_equal(['1', '2', '4', '7', '8', '11', '13', '14'], 
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