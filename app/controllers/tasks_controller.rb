class TasksController < ApplicationController
  before_action :check_params, only: [:create]

  def index
    if params[:sort_expired] == "true"
      @tasks = Task.all.order(deadline: "DESC")
    else  
    # elsif params[:sort_expired] == "false"
      @tasks = Task.all.order(created_at: "DESC")
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task=Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('view.task created')
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('view.task edited')
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:t('view.task deleted')
  end

  private

  def task_params
    params.require(:task).permit(:content,:status,:priority,:deadline)
  end
end
