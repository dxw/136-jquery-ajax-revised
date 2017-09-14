require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incomplete_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, task: { complete: @task.complete, name: @task.name }
    end

    assert_redirected_to tasks_url
  end

  test "should update task" do
    put :update, id: @task, task: { complete: @task.complete, name: @task.name }
    assert_redirected_to tasks_url
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, id: @task
    end

    assert_redirected_to tasks_path
  end
  
  # Search
  test "should search list" do
    # Create some examples
    Task.create(name: "Batman")
    Task.create(name: "Robin")
    Task.create(name: "Batmanuel") # from The Tick, look it up
    # Search
    get :index, search: "bat"
    assert_response :success
    assert response.body.include? "Batman" # not good enough, will be true
    assert response.body.include? "Batmanuel" 
    assert !response.body.include?("Robin")
  end

end
