class TasksController < ApplicationController
  before_action :authenticate_user, only: [:index, :new]

  def index
    if params[:sort_expired_deadline] == "true"
      @tasks = current_user.tasks.order(deadline: "DESC")
      #kaminari対応
      @tasks = @tasks.page(params[:page])
    elsif params[:sort_expired_priority] == "true"
      @tasks = current_user.tasks.order(priority: "DESC")
      #kaminari対応
      @tasks = @tasks.page(params[:page])
    else
      # パラメータとして内容を受け取っている場合は絞って検索する
      @tasks = current_user.tasks
      @tasks = @tasks.page(params[:page])
      if params[:search].present?
        @tasks = @tasks.get_by_content params[:search]
      end
      if params[:status].present?
        @tasks = @tasks.get_by_status params[:status]
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task=current_user.tasks.new(task_params)
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

  def authenticate_user
    unless logged_in?
      redirect_to sessions_new_path
    end
  end
end
