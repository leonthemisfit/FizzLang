require './examples/assignbuzz'

module UnitTests
    # Test Case for the Examples::AssignBuzz class
    class TestAssignBuzz < Test::Unit::TestCase
        # Prepare +fb+ instance variable for use in tests
        def setup
            @ab = Examples::AssignBuzz.new(1..15)
        end

        # Test the class methods on AssignBuzz
        def test_static
            assert_equal('1', Examples::AssignBuzz.check(1))
            assert_equal('Assign', Examples::AssignBuzz.check(3))
            assert_equal('Buzz', Examples::AssignBuzz.check(5))
            assert_equal('AssignBuzz', Examples::AssignBuzz.check(15))
            assert_equal(3, Examples::AssignBuzz.Assign)
            assert_equal(5, Examples::AssignBuzz.Buzz)
            assert_equal(['1', '2', 'Assign'], Examples::AssignBuzz.check_range(1..3))
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
end