require 'test_helper'

class WorkGuide::GuideTest < Minitest::Test
  def setup
    FakeFS.activate!
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_create_and_update_guide
    guide = WorkGuide::Guide.create(
      description: 'description'
    )

    assert_equal 'description', guide.description
    assert_equal 'daily', guide.cycle
    assert_equal nil, guide.done_at
    assert_equal 'medium', guide.priority

    guides = WorkGuide::Guide.all
    assert_equal 1, guides.size
    assert_equal [guide], guides

    guide.description = 'foo'
    guide.done_at = '2015-10-31 00:00:00'
    WorkGuide::Guide.save

    guide = WorkGuide::Guide.all.first

    assert_equal 'foo', guide.description
    assert_equal Time.new(2015, 10, 31), guide.done_at.to_time
  end
end
