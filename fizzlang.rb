module FizzLang
    def self.included(klass)
        klass.extend(Fizzy)
    end

    def initialize(range)
        @range = range
    end

    def each
        enum = as_enum(:each)

        if block_given?
            enum.each { |str| yield str }
        else
            enum
        end
    end

    def with_val
        if block_given?
            @range.each do |n|
                yield n, self.class.check(n)
            end
        else
            @range.map { |n| [ n, self.class.check(n) ] }.to_enum(:map)
        end
    end

    def map(&block)
        res = as_enum(:map)

        if block_given?
            res = res.map { |str| block.call(str) }
        end

        res
    end

    def select(&block)
        res = as_enum(:select)

        if block_given?
            res = res.select(&block)
        end

        res
    end

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

module Fizzy
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

    def check(n)
        res = @tests.reduce('') do |acc, (sym, val)|
            (n % val).zero? ? acc + sym.to_s : acc
        end

        res.empty? ? n.to_s : res
    end
end