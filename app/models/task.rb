class Task < ActiveRecord::Base

  def self.search(query)
    # This is really simplistic, we just look for substring in the name
    tasks = Task.arel_table
    Task.where(tasks[:name].matches("%#{query}%"))
  end

end
