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

  def test_alert_after_terms
    time = Time.now
    guide = WorkGuide::Guide.new(description: 'test', cycle: 'hourly', done_at: time.to_s)

    Timecop.freeze(1.hour.since(time).beginning_of_hour + 1) do
      assert guide.should_do?
    end
    Timecop.freeze(1.hour.since(time).beginning_of_hour) do
      refute guide.should_do?
    end

    guide.cycle = 'daily'
    Timecop.freeze(1.day.since(time).beginning_of_day + 1) do
      assert guide.should_do?
    end
    Timecop.freeze(1.day.since(time).beginning_of_day) do
      refute guide.should_do?
    end

    guide.cycle = 'weekly'
    Timecop.freeze(1.week.since(time).beginning_of_day + 1) do
      assert guide.should_do?
    end
    Timecop.freeze(1.week.since(time).beginning_of_day) do
      refute guide.should_do?
    end

    guide.cycle = 'monthly'
    Timecop.freeze(1.month.since(time).beginning_of_month + 1) do
      assert guide.should_do?
    end
    Timecop.freeze(1.month.since(time).beginning_of_month) do
      refute guide.should_do?
    end
  end

  def test_priority_rate
    high = WorkGuide::Guide.new(description: 'desc', priority: 'high')
    medium = WorkGuide::Guide.new(description: 'desc', priority: 'medium')
    low = WorkGuide::Guide.new(description: 'desc', priority: 'low')

    assert_equal [high, medium, low], [high, medium, low].shuffle.sort_by(&:priority_rate)
  end
end
