class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # def ensure_correct_user
  #   @current_user = User.find_by(id:  session[:user_id])
  #   if @current_user.id !=  params[:id].to_i
  #     redirect_to new_session_path
  #   end
  # end
end
