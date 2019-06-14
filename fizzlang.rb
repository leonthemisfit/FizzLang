module FizzLang
    def self.included(klass)
        klass.extend(Fizzy)
    end

    def initialize(range)
        @range = range
    end

    private

    def as_enum(method)
        @range.map { |i| self.class.check(i) }.to_enum(method)
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