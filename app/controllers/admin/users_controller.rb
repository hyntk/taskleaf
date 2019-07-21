class Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user, only: [:index]

  def index
    @users = User.all.order("created_at DESC")
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice:t('view.task deleted')
  end

  private

  def authenticate_admin_user
    unless current_user.admin?
      redirect_to sessions_new_path
    end
  end
end
