# frozen_string_literal: true

# Module that holds all the private utility singleton methods
module FizzLangUtil
  private

  def add_test_method(sym)
    define_singleton_method(sym) do |n = nil, str = ''|
      if n.nil?
        @tests[sym]
      else
        public_send("#{sym}=", n)
        public_send("#{sym}_string=", str) unless str.empty?
      end
    end
  end

  def add_test_setter(sym)
    define_singleton_method("#{sym}=") do |n|
      @tests[sym] = n
    end
  end

  def set_block(sym, &block)
    @procs[sym] = block
  end

  def clear_string(sym)
    @strings[sym] = sym.to_s
    @procs[sym] = nil
  end

  def add_string_method(sym)
    define_singleton_method("#{sym}_string") do |str = '', &block|
      set_block(sym, &block) if block
      if str.nil? || str == :reset
        clear_string(sym)
      elsif !str.empty?
        @strings[sym] = str
      end
      @strings[sym]
    end
  end

  def add_string_setter(sym)
    define_singleton_method("#{sym}_string=") do |str|
      @strings[sym] = str
    end
  end

  def add_instance_getters(sym)
    define_method(sym) do
      self.class.tests[sym]
    end

    define_method("#{sym}_string") do
      self.class.strings[sym] || sym.to_s
    end
  end

  def add_methods(sym)
    add_test_method(sym)
    add_test_setter(sym)
    add_string_method(sym)
    add_string_setter(sym)
    add_instance_getters(sym)
  end

  def add_tests(*args)
    @tests ||= {}
    @strings ||= {}
    @procs ||= {}

    args.each do |sym|
      next unless @tests[sym].nil?

      add_methods(sym)
    end

    @tests
  end

  def get_string(sym, val)
    if proc?(sym)
      @procs[sym].call(val) || @strings[sym] || sym.to_s
    elsif string?(sym)
      @strings[sym] || sym.to_s
    else
      sym.to_s
    end
  end

  def proc?(sym)
    !@procs[sym].nil?
  end

  def string?(sym)
    !@strings[sym].nil?
  end

  def process_block(&block)
    block_tests = {}
    block.call(block_tests)

    process_kwargs(**block_tests)
  end

  def process_kwargs(**kwargs)
    syms = []
    kwargs.each { |sym, _| syms << sym }

    add_tests(*syms)

    kwargs.each do |sym, (val, str)|
      public_send(sym, val, str || '')
    end

    @tests
  end
end
