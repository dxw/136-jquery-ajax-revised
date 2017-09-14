require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "search" do
    Task.create(name: "Batman")
    Task.create(name: "Robin")
    Task.create(name: "Batmanuel") # from The Tick, look it up
    # Case insensitive substring search
    # Tests could be brittle because of ordering
    assert Task.search("bat").map{|x| x.name} == ["Batman", "Batmanuel"]
    assert Task.search("robin").map{|x| x.name} == ["Robin"]
  end

end
