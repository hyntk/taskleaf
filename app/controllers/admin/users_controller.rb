class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user, only: [:index]

  def index
    @users = User.all.order("created_at DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render new_admin_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('view.user edited')
    else
      render admin_users_path, notice: t('編集に失敗しました')
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = Task.where(user_id: @user.id)
    # @tasks = @tasks.page(params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice:t('view.user deleted')
    else
      redirect_to admin_users_path, notice:t('view.delete failed')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end

  def authenticate_admin_user
    unless current_user.admin?
      redirect_to tasks_path
      flash[:notice] = t('view.you do not have the authority')
    end
  end
end
