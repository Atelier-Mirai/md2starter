# frozen_string_literal: true

require "test_helper"

class TestMD2Starter < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MD2Starter::VERSION
  end

  def test_it_does_something_useful
    assert_equal 2, 1 + 1
  end
end
