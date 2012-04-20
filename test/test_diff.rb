require 'test/unit'
require_relative 'diff'
require_relative 'test_cases'

class DiffTest < Test::Unit::TestCase

  include DiffStringTests
  include DiffArrayTests
  include DiffStressTest

  def difftest(a, b)
    diff = Diff.new(a, b)
    c = a.patch(diff)
    assert_equal(b, c)
    diff = Diff.new(b, a)
    c = b.patch(diff)
    assert_equal(a, c)
  end

end
