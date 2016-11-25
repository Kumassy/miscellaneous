require 'test/unit'
require_relative 'ppap'

class PPAP
  attr_accessor :ppap_space, :ppaps
end

class PPAPTest < Test::Unit::TestCase
  def setup
    @ppap = PPAP.new
  end

  def test_apple_pen
    @ppap.I_have_a "Pen"
    assert_equal(["Pen"], @ppap.ppap_space)

    @ppap.I_have_a "Apple"
    assert_equal(["Pen", "Apple"], @ppap.ppap_space)
  end

  def test_uh!
    @ppap.I_have_a "Pen"
    @ppap.I_have_a "Apple"
    assert_equal({}, @ppap.ppaps)

    @ppap.uh! "Apple Pen"

    assert_equal([], @ppap.ppap_space)
    assert(@ppap.respond_to? "apple_pen")

  end

  def test_singleton_method
    @ppap.I_have_a "Pen"
    @ppap.I_have_a "Apple"
    @ppap.uh! "Apple Pen"

    assert_equal([], @ppap.ppap_space)
    @ppap.apple_pen
    assert_equal(["Pen", "Apple"], @ppap.ppap_space)
  end
end




    # ppap = PPAP.new
    # ppap.I_have_a "Pen"
    # ppap.I_have_a "Apple"
    # ppap.uh! "Apple Pen"
    # ppap.I_have_a "Pen"
    # ppap.I_have_a "Pineapple"
    # ppap.uh! "Pineapple Pen"
    #
    # ppap.apple_pen
    # ppap.pineapple_pen
    # puts ppap.apple_pen
    # puts ppap.pineapple_pen
