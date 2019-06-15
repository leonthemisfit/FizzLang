# Module to include to get the instance methods that can be used
# for Fizz Buzz classes. Automatically extends Fizzy.
module FizzLang

    # Automatically extend klass on inclusion with Fizzy
    # * +klass+ -- The Class being extended
    def self.included(klass)
        klass.extend(Fizzy)
    end

    # Default initializer used to get a range to use in list based methods
    # * +range+ -- A numeric range such as +1..10+
    def initialize(range)
        @range = range
    end

    # Get the result at a given index in the provided range
    # * +ind+ -- the Integer index of the result to return
    def [](ind)
        as_array[ind]
    end

    # Perform an action for each item in the result. If a block is given this
    # will go through each result yielding each. If no block is passed an :each
    # enum will be returned.
    def each
        enum = as_enum(:each)

        if block_given?
            enum.each { |str| yield str }
        else
            enum
        end
    end

    # Method to obtain results and the values that were used to get the results. When
    # called with a block this will yield the value and result for each item. When
    # the block is omitted a map will be created with value and result pairs and
    # return as a :map enum
    def with_val
        if block_given?
            @range.each do |n|
                yield n, self.class.check(n)
            end
        else
            @range.map { |n| [ n, self.class.check(n) ] }.to_enum(:map)
        end
    end

    # Iterate over each result and perform a given action on it as in other map functions.
    # If called with a block the actual map will be performed otherwise a :map enum will
    # be returned.
    def map(&block)
        res = as_enum(:map)

        if block_given?
            res = res.map { |str| block.call(str) }
        end

        res
    end

    # Filter the results with a select statement. If a block is passed the select is called
    # with the block, otherwise returns a :select enum
    def select(&block)
        res = as_enum(:select)

        if block_given?
            res = res.select(&block)
        end

        res
    end

    # Filter the results with a reject statement. If a block is passed the reject is called
    # with the block, otherwise returns a :reject enum
    def reject(&block)
        res = as_enum(:reject)

        if block_given?
            res = res.reject(&block)
        end

        res
    end

    private

    def as_array
        @arr ||= @range.map { |i| self.class.check(i) }
    end

    def as_enum(method)
        as_array.to_enum(method)
    end
end

# Module that contains the main parts of the actual FizzLang DSL.
# The methods here are used to dyanmically generate the appropriated
# methods on the class being extended.
module Fizzy

    # Prepare and define the methods and names that will be used to test
    # values in a call to check().
    # * +args+ -- Variables list of arguments as symbols used to create the class methods
    def test_cases(*args)
        @tests ||= nil
        if @tests.nil?
            @tests = {}
            args.each do |sym|
                define_singleton_method(sym) do |n|
                    @tests[sym] ||= n
                end
            end
        end
        @tests
    end

    # Test +n+ against the test cases stored on the Class
    # * +n+ -- A Numeric representing the number to be tested
    def check(n)
        res = @tests.reduce('') do |acc, (sym, val)|
            (n % val).zero? ? acc + sym.to_s : acc
        end

        res.empty? ? n.to_s : res
    end
end