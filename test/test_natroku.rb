require 'minitest_helper'

class TestNatroku < MiniTest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Natroku::VERSION
  end

  def test_it_does_something_useful
    assert Natroku::Cli.new(ARGV)
  end
end
