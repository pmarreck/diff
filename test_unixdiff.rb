require 'test/unit'
require_relative 'diff'
require_relative 'test_cases'

class UnixDiffTest < Test::Unit::TestCase

  include DiffStringTests
  include DiffArrayTests
  #include DiffStressTest

  def makefile(filename, ary)
    ary = Array[ary] unless ary.is_a? Array
    File.open(filename, "w") { |f|
      ary.each { |elem|
        f.puts elem.to_s
      }
    }
  end

  def rundiff(prog)
    res = []
    IO.popen("#{prog} file1 file2") { |f|
      while ln = f.gets
        res << ln
      end
    }
    res
  end

  def difftest(a, b)
    makefile("file1", a)
    makefile("file2", b)
    result1 = rundiff("diff")
    result2 = rundiff("./unixdiff.rb");
    assert_equal(result1, result2)
    File.delete("file1","file2")
  end
end
