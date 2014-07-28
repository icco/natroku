require 'minitest_helper'

class TestSpec < MiniTest::Unit::TestCase
  def test_it_parses_simple_pair
    spec = ::Natroku::Spec.parse "icco/sadnat.com"
    assert_equal "icco", spec.user
    assert_equal "sadnat.com", spec.repo
    assert_equal "HEAD", spec.ref
  end

  def test_it_parses_pair_with_long_sha
    spec = ::Natroku::Spec.parse "icco/sadnat.com@13ec16fbd4ea85e997dc05e47bae03e5cd849b83"
    assert_equal "icco", spec.user
    assert_equal "sadnat.com", spec.repo
    assert_equal "13ec16fbd4ea85e997dc05e47bae03e5cd849b83", spec.ref
  end

  def test_it_parses_pair_with_short_sha
    spec = ::Natroku::Spec.parse "icco/sadnat.com@13ec16fbd4"
    assert_equal "icco", spec.user
    assert_equal "sadnat.com", spec.repo
    assert_equal "13ec16fbd4", spec.ref
  end
end
