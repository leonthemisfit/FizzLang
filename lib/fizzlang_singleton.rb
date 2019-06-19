# frozen_string_literal: true

require './lib/fizzlang_util.rb'

# Module that contains the main parts of the actual FizzLang DSL.
# The methods here are used to dyanmically generate the appropriated
# methods on the class being extended.
module FizzLangSingleton
  include FizzLangUtil

  # Exposes the internal tests hash so that classes can use it internally
  attr_reader :tests

  # Exposes the internal strings hash so that classes can use it internally
  attr_reader :strings

  # Prepare and define the methods and names that will be used to test
  # values in a call to check(). The method will also accept a block to which
  # a hash will be passed to be populated with values. It should be noted that
  # if arguments and a block are passed the arguments are ignored in favor of
  # using the block. A third option to calling this method is to use keyword
  # arguments. Only one method will be used to setup the class and the order
  # of operations is block, keyword args, argument list.
  # ========================================
  # * +args+ -- List of arguments as symbols used to create the class methods
  # * +kwargs+ -- Set of keyword arguments used to create the class methods
  # ========================================
  #     class FizzBuzz
  #       include FizzLang
  #
  #       test_cases :Fizz, :Buzz
  #
  #       Fizz 3
  #       Buzz 5
  #     end
  # ========================================
  #     class BlockBuzz
  #       include FizzLang
  #
  #       test_cases do |cases|
  #         cases[:Block] = 3
  #         cases[:Buzz] = 5
  #       end
  #     end
  # ========================================
  #     class KeyBuzz
  #       include FizzLang
  #
  #       test_cases Key: 3, Buzz: 5
  #     end
  # ========================================
  #     class AssignBuzz
  #       include FizzLang
  #
  #       test_cases :Assign, :Buzz
  #     end
  #
  #     AssignBuzz.Assign = 3
  #     AssignBuzz.Buzz(5)
  # ========================================
  #     class BarBaz
  #       include FizzLang
  #
  #       test_cases :bar, :baz
  #
  #       bar 3, 'Bar'
  #       baz 5, 'Baz'
  #     end
  def test_cases(*args, **kwargs, &block)
    if block_given?
      process_block(&block)
    elsif kwargs.length.positive?
      process_kwargs(**kwargs)
    elsif args.length.positive?
      add_tests(*args)
    else
      @tests || {}
    end
  end

  # Test +n+ against the test cases stored on the Class
  # ========================================
  # * +n+ -- A Numeric representing the number to be tested
  # ========================================
  #     class FizzBuzz
  #       include FizzLang
  #
  #       test_cases :Fizz, :Buzz
  #
  #       Fizz 3
  #       Buzz 5
  #     end
  #
  #     FizzBuzz.check(15)
  def check(n_val)
    res = ''

    tests.each do |sym, val|
      res += get_string(sym, n_val) if (n_val % val).zero?
    end

    res.empty? ? n_val.to_s : res
  end

  # Class method added in order to quickly get an array of results instead
  # of creating an instance and getting the results from that. This is just
  # a wrapper aound the creation of a new class.
  # ========================================
  # * +rng+ -- A range of numbers such as +1..10+ to get results for
  # ========================================
  #     results = FizzLang.check_range(1..10)
  def check_range(rng)
    new(rng).results
  end
end
