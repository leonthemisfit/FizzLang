# Module to include to get the instance methods that can be used
# for Fizz Buzz classes. Automatically extends Fizzy.
# ========================================
# For the examples in this documentation to function the FizzLang module must
# be included in a class.
module FizzLang

    # Automatically extend klass on inclusion with Fizzy
    # ========================================
    # * +klass+ -- The Class being extended
    def self.included(klass)
        klass.extend(Fizzy)
    end

    # Default initializer used to get a range to use in list based methods
    # ========================================
    # * +range+ -- A numeric range such as +1..10+
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    def initialize(range)
        @range = range
    end

    # Get the result at a given index in the provided range
    # ========================================
    # * +ind+ -- the Integer index of the result to return
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    #       puts fizzy[0]
    def [](ind)
        as_array[ind]
    end

    # Get the results from all the checks as an array
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    #       puts fizzy.results
    def results
        as_array
    end

    # Perform an action for each item in the result. If a block is given this
    # will go through each result yielding each. If no block is passed an :each
    # enum will be returned.
    # ========================================
    #       fizzy = FizzLang.new(1..5)
    #       fizzy.each { |result| puts result }
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
    # ========================================
    #       fizzy = FizzLang.new(1..15)
    #       fizzy.with_val.map do |value, result|
    #           puts "#{value}: #{result}"
    #       end
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
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    #       fizzy.map { |result| result.upcase }
    def map(&block)
        res = as_enum(:map)

        if block_given?
            res = res.map(&block)
        end

        res
    end

    # Filter the results with a select statement. If a block is passed the select is called
    # with the block, otherwise returns a :select enum
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    #       fizzy.select { |result| result.include?('3') }
    def select(&block)
        res = as_enum(:select)

        if block_given?
            res = res.select(&block)
        end

        res
    end

    # Filter the results with a reject statement. If a block is passed the reject is called
    # with the block, otherwise returns a :reject enum
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    #       fizzy.reject { |result| result.include?('5') }
    def reject(&block)
        res = as_enum(:reject)

        if block_given?
            res = res.reject(&block)
        end

        res
    end

    # Join the results into a single string with the +delim+
    # ========================================
    # * +delim+ -- A string to be used a delimeter between values, the dafault value is a single space
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    #       spaces = fizzy.join
    #       underscores = fizzy.join('_')
    def join(delim = ' ')
        as_array.join(delim)
    end

    # Reduce the results to a single value using a simply wrapper around
    # the Ruby reduce method. If a block is given it returns the result
    # of the reduction, with no block it returns an :reduce enum
    # ========================================
    # * +start+ -- Starting value for the reduce, defaults to empty string
    # ========================================
    #       fizzy = FizzLang.new(1..10)
    #       fizzy.reduce { |acc, res| acc + res }
    def reduce(start = '', &block)
        if block_given?
            as_array.reduce(start, &block)
        else
            as_enum(:reduce)
        end
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
    # Exposes the internal tests hash so that classes can use it internally
    attr_reader :tests

    # Exposes the internal strings hash so that classes can use it internally
    attr_reader :strings

    # Prepare and define the methods and names that will be used to test
    # values in a call to check(). The method will also accept a block to which
    # a hash will be passed to be populated with values. It should be noted that
    # if arguments and a block are passed the arguments are ignored in favor of
    # using the block. A third option to calling this method is to use keyword arguments.
    # Only one method will be used to setup the class and the order of operations is
    # block, keyword args, argument list.
    # ========================================
    # * +args+ -- Variable list of arguments as symbols used to create the class methods
    # * +kwargs+ -- Set of keyword arguments used to create the class methods
    # ========================================
    #       class FizzBuzz
    #           include FizzLang
    #           
    #           test_cases :Fizz, :Buzz
    #           
    #           Fizz 3
    #           Buzz 5
    #       end
    # ========================================
    #       class BlockBuzz
    #           include FizzLang
    #           
    #           test_cases do |cases|
    #               cases[:Block] = 3
    #               cases[:Buzz] = 5
    #           end
    #       end
    # ========================================
    #       class KeyBuzz
    #           include FizzLang
    #           
    #           test_cases Key: 3, Buzz: 5
    #       end
    # ========================================
    #       class AssignBuzz
    #           include FizzLang
    #           
    #           test_cases :Assign, :Buzz
    #       end
    #       
    #       AssignBuzz.Assign = 3
    #       AssignBuzz.Buzz(5)
    # ========================================
    #       class BarBaz
    #           include FizzLang
    #           
    #           test_cases :bar, :baz
    #           
    #           bar 3, 'Bar'
    #           baz 5, 'Baz'
    #       end
    def test_cases(*args, **kwargs, &block)
        unless (args.length > 0) || (kwargs.length > 0) || (block_given?)
            return @tests || {}
        end

        return process_block(&block) if block_given?
        return process_kwargs(**kwargs) if kwargs.length > 0

        add_tests(*args)
    end

    # Test +n+ against the test cases stored on the Class
    # ========================================
    # * +n+ -- A Numeric representing the number to be tested
    # ========================================
    #       class FizzBuzz
    #           include FizzLang
    #           
    #           test_cases :Fizz, :Buzz
    #           
    #           Fizz 3
    #           Buzz 5
    #       end
    #       
    #       FizzBuzz.check(15)
    def check(n)
        res = ''
        
        tests.each do |sym, val|
            if (n % val).zero?
                res += @strings[sym] || sym.to_s
            end
        end

        res.empty? ? n.to_s : res
    end

    # Class method added in order to quickly get an array of results instead
    # of creating an instance and getting the results from that. This is just
    # a wrapper aound the creation of a new class.
    # ========================================
    # * +rng+ -- A range of numbers such as +1..10+ to get results for
    # ========================================
    #       results = FizzLang.check_range(1..10)
    def check_range(rng)
        self.new(rng).results
    end

    private

    def add_tests(*args)
        @tests ||= {}
        @strings ||= {}
        
        args.each do |sym|
            next unless @tests[sym].nil?

            define_singleton_method(sym) do |n = nil, str = ''|
                if n.nil?
                    @tests[sym]
                else
                    self.public_send("#{sym}=", n)
                    self.public_send("#{sym}_string=", str) unless str.empty?
                end
            end

            define_singleton_method("#{sym}=") do |n|
                @tests[sym] = n
            end

            define_singleton_method("#{sym}_string") do |str = ''|
                if str.empty?
                    @strings[sym]
                elsif str.nil?
                    self.public_send("#{sym}_string=", sym.to_s)
                else
                    self.public_send("#{sym}_string=", str)
                end
            end

            define_singleton_method("#{sym}_string=") do |str|
                @strings[sym] = str
            end

            define_method(sym) do
                self.class.tests[sym]
            end

            define_method("#{sym}_string") do
                self.class.strings[sym] || sym.to_s
            end 
        end
        
        @tests
    end

    def process_block(&block)
        block_tests = {}
        block.call(block_tests)
        
        process_kwargs(**block_tests)
    end

    def process_kwargs(**kwargs)
        syms = []
        kwargs.each { |sym, val| syms << sym }

        add_tests(*syms)

        kwargs.each do |sym, (val, str)|
            self.public_send(sym, val, str || '')
        end

        @tests
    end
end