require 'test_helper'

class WorkGuideTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::WorkGuide::VERSION
  end
end
