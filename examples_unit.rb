require 'test/unit'
require './examples'

Dir['./unit_tests/*rb'].each { |test_file| require test_file }