require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "search" do
    Task.create(name: "Batman")
    Task.create(name: "Robin")
    Task.create(name: "Batmanuel") # from The Tick, look it up
    # Case insensitive substring search
    # Tests could be brittle because of ordering
    assert Task.search("bat").map(&:name) == ["Batman", "Batmanuel"]
    assert Task.search("robin").map(&:name) == ["Robin"]
  end
  
  test "search with other query params" do
    Task.create(name: "Batman", complete: false)
    Task.create(name: "Robin", complete: true)
    assert Task.where(complete: true).search("bat").map(&:name) == []
    assert Task.where(complete: false).search("bat").map(&:name) == ["Batman"]
    assert Task.where(complete: true).search("rob").map(&:name) == ["Robin"]
    assert Task.where(complete: false).search("rob").map(&:name) == []
  end

end
