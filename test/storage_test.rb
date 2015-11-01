require 'test_helper'

class WorkGuide::StorageTest < Minitest::Test
  def setup
    FakeFS.activate!
  end

  def teardown
    FakeFS.deactivate!
  end

  def test_store_json
    WorkGuide::Storage.new("test").store({ foo: 1, bar: 2 }.to_json)
    assert_equal({ 'foo' => 1, 'bar' => 2 }, WorkGuide::Storage.new("test").load)
    assert_equal([], WorkGuide::Storage.new("foo").load)
  end
end
