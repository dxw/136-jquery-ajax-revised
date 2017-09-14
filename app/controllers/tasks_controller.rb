class TasksController < ApplicationController
  def index
    @incomplete_tasks = Task.where(complete: false)
    @complete_tasks = Task.where(complete: true)
    if params[:search]
      @incomplete_tasks = @incomplete_tasks.search(params[:search])
      @complete_tasks = @complete_tasks.search(params[:search])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create!(task_params)
    redirect_to tasks_url
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(task_params)
    redirect_to tasks_url
  end

  def destroy
    @task = Task.destroy(params[:id])
    redirect_to tasks_url
  end

  def task_params
    params.require(:task).permit(:complete, :name)
  end

end
