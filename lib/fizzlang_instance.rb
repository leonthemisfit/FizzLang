# frozen_string_literal: true

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
    klass.extend(FizzLangSingleton)
  end

  # Default initializer used to get a range to use in list based methods
  # ========================================
  # * +range+ -- A numeric range such as +1..10+
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  def initialize(range)
    @range = range
  end

  # Get the result at a given index in the provided range
  # ========================================
  # * +ind+ -- the Integer index of the result to return
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  #     puts fizzy[0]
  def [](ind)
    array[ind]
  end

  # Get the results from all the checks as an array
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  #     puts fizzy.results
  def results
    array
  end

  # Perform an action for each item in the result. If a block is given this
  # will go through each result yielding each. If no block is passed an :each
  # enum will be returned.
  # ========================================
  #     fizzy = FizzLang.new(1..5)
  #     fizzy.each { |result| puts result }
  def each
    enum = as_enum(:each)

    if block_given?
      enum.each { |str| yield str }
    else
      enum
    end
  end

  # Method to obtain results and the values that were used to get the results.
  # When called with a block this will yield the value and result for each item.
  # When the block is omitted a map will be created with value and result pairs
  # and return as a :map enum
  # ========================================
  #     fizzy = FizzLang.new(1..15)
  #     fizzy.with_val.map do |value, result|
  #       puts "#{value}: #{result}"
  #     end
  def with_val
    if block_given?
      @range.each do |n|
        yield n, self.class.check(n)
      end
    else
      @range.map { |n| [n, self.class.check(n)] }.to_enum(:map)
    end
  end

  # Iterate over each result and perform a given action on it as in other map
  # functions. If called with a block the actual map will be performed otherwise
  # a :map enum willbe returned.
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  #     fizzy.map { |result| result.upcase }
  def map(&block)
    res = as_enum(:map)
    res.map(&block) if block_given?
  end

  # Filter the results with a select statement. If a block is passed the select
  # is called with the block, otherwise returns a :select enum
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  #     fizzy.select { |result| result.include?('3') }
  def select(&block)
    res = as_enum(:select)
    res.select(&block) if block_given?
  end

  # Filter the results with a reject statement. If a block is passed the reject
  # is called with the block, otherwise returns a :reject enum
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  #     fizzy.reject { |result| result.include?('5') }
  def reject(&block)
    res = as_enum(:reject)
    res.reject(&block) if block_given?
  end

  # Join the results into a single string with the +delim+
  # ========================================
  # * +delim+ -- A string to be used a delimeter between values.
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  #     spaces = fizzy.join
  #     underscores = fizzy.join('_')
  def join(delim = ' ')
    array.join(delim)
  end

  # Reduce the results to a single value using a simply wrapper around
  # the Ruby reduce method. If a block is given it returns the result
  # of the reduction, with no block it returns an :reduce enum
  # ========================================
  # * +start+ -- Starting value for the reduce, defaults to empty string
  # ========================================
  #     fizzy = FizzLang.new(1..10)
  #     fizzy.reduce { |acc, res| acc + res }
  def reduce(start = '', &block)
    if block_given?
      array.reduce(start, &block)
    else
      as_enum(:reduce)
    end
  end

  private

  def array
    @array ||= @range.map { |i| self.class.check(i) }
  end

  def as_enum(method)
    array.to_enum(method)
  end
end
